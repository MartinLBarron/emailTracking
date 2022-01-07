allhours <- tibble(hour=seq(0,23))
AllMail2021received <- AllMail %>%
  filter(year(date)==2021 & Message_Sent==0) %>%
  group_by(hour) %>%
  summarize(received=n()) %>%
  full_join(., allhours, by="hour") %>%
  replace_na(list(sent=0)) %>%
  arrange(hour)

AllMail2021sent <- AllMail %>%
  filter(year(date)==2021 & Message_Sent==1) %>%
  group_by(hour) %>%
  summarize(sent=n()) %>%
  full_join(., allhours, by="hour") %>%
  replace_na(list(sent=0)) %>%
  arrange(hour)



ggplot(AllMail2021received) + 
  geom_col(aes(x=hour, y=received), fill="blue", col="blue")+
  scale_y_continuous(labels = comma)+
  xlab("Hour of Day")+
  ylab("Email Received")+
  labs(title="Email Recevied Accross the Day")+
  theme_minimal()

ggsave("output/5_Hourly_Received_Summary.png", h=4, w=6)

ggplot(AllMail2021sent) + 
  geom_col(aes(x=hour, y=sent), fill="blue", col="blue")+
  scale_y_continuous(labels = comma)+
  xlab("Hour of Day")+
  ylab("Email Sent")+
  labs(title="Email Sent Accross the Day")+
  theme_minimal()

ggsave("output/6_Hourly_Sent_Summary.png", h=4, w=6)



