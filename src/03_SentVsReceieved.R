
DailyMail2021 <- DailyMail %>%
  filter(Year==2021)

corr <- cor(DailyMail2021$MailReceived, DailyMail2021$MailSent)

ggplot(data=DailyMail2021) +
  geom_point(aes(x=MailReceived, y=MailSent)) +
  labs(title="Relationship between Received and Sent Mail")+
  annotate (geom="text", col="blue", label=paste0("Correlation =\n", round(corr,digits=2)), x=110, y=45)+
  labs(title="2021 Recevied vs. Sent Emails")+
  xlab("Received") +
  ylab("Sent") +
  theme_minimal()


ggsave("output/ReceivedVsSent.png", h=4, w=6)

