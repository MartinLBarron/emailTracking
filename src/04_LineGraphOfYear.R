
DailyMail2021 <- DailyMail %>%
  filter(Year==2021)

df <- tibble(date=seq(as.Date("2022-01-01"), as.Date("2022-03-01"), "days"))

DailyMail2021extended=bind_rows(DailyMail2021, df)
ReceivedMean = mean(DailyMail2021$MailReceived, na.rm=T)
SentMean = mean(DailyMail2021$MailSent, na.rm=T)



# line graph of email volume ----------------------------------------------

ggplot (data=DailyMail2021extended) +
  geom_point(aes(x=date, y=MailReceived), alpha=.25) +
  geom_line(aes(x=date, y=ReceivedRolling), size=1, col="blue") +
  geom_hline(yintercept =ReceivedMean, col="black", linetype="dashed") +
  annotate (geom="text", label="Yearly Mean", x=as.Date("2022-02-10"), y=ReceivedMean+5)+
  annotate (geom="text", label="7-day Avg.", x=as.Date("2022-02-10"), y=18, col="blue")+
  labs(title="2021 Email Received")+
  xlab("")+
  ylab("Email Received")+
  theme_minimal()


ggsave("output/3_2021EmailReceived.png", h=4, w=6)

ggplot (data=DailyMail2021extended) +
  geom_point(aes(x=date, y=MailSent), alpha=.25) +
  geom_line(aes(x=date, y=SentRolling), size=1, col="blue") +
  geom_hline(yintercept =SentMean, col="black", linetype="dashed") +
  annotate (geom="text", label="Yearly Mean", x=as.Date("2022-02-10"), y=SentMean+2)+
  annotate (geom="text", label="7-day Avg.", x=as.Date("2022-02-10"), y=8, col="blue")+
  labs(title="2021 Email Sent")+
  xlab("")+
  ylab("Email Sent")+
  theme_minimal()


ggsave("output/4_2021EmailSent.png", h=4, w=6)
