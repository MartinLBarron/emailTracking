

Create_Daily_DataFrame <- function(){
  
  
  #Make connection to SQL lite database and get tables so we can explore
  #database is stored in ~/Library/Group Containers/UBF8T346G9.Office/Outlook/Outlook 15 Profiles/Main Profile/Data
  # copy to folder so as to not corrupt
  con <- dbConnect(RSQLite::SQLite(), dbname = "data/Outlook.sqlite")
  tables <- dbListTables(con)
  
  #Query mail table to get all mail stored in database
  df <- dbGetQuery(conn = con, statement = paste("SELECT * FROM Mail", sep = ","))
  
  #limit to key fields and convert times to something reasonable
  df <- df %>%
    select (Record_RecordID, Message_NormalizedSubject, Message_SenderList, Message_TimeReceived, Message_TimeSent, Message_Sent) %>%
    mutate (TimeSent = as.POSIXct(Message_TimeSent,origin = "1970-01-01",tz = ""),
            TimeReceived = as.POSIXct(Message_TimeReceived,origin = "1970-01-01",tz = ""),
            date=date(TimeReceived),
            hour=hour(TimeReceived))
  
  write_parquet(df, "data/AllMail.parquet")
  
  # Create sent and Received Files
  SentMail <- df %>%
    filter(Message_Sent==1 & Message_SenderList=="Martin L Barron")
  
  ReceivedMail <- df %>% 
    filter (Message_Sent==0 & Message_SenderList!="Martin L Barron")
  
  # Create daily counts
  DailySentMail <- SentMail %>%
    group_by(date) %>%
    summarize (MailSent=n())
  
  DailyReceivedMail <- ReceivedMail %>%
    group_by(date) %>%
    summarize (MailReceived=n())
  
  #create range of dates.  We may not have all dates in send/received
  AllDates <- tibble(date=seq(as.Date("2017/10/16"), as.Date("2021/12/31"), "days"))
  
  DailyMail <- full_join(AllDates, DailyReceivedMail, by="date") %>%
    full_join(., DailySentMail, by="date")%>%
    arrange(date)
  
  DailyMail <- DailyMail %>%
    replace_na(list(MailReceived=0,MailSent=0)) %>%
    mutate(Year=year(date),
           DayofWeek=wday(date),
           Weekday=ifelse(DayofWeek %in% c(1,7),F,T),
           ReceivedRolling = rollapply(MailReceived, 7, mean, align="right", fill=NA),
           SentRolling = rollapply(MailSent, 7, mean, align="right", fill=NA))
  
  write_parquet(DailyMail, "data/DailyMail.parquet")
  return(DailyMail)
}





