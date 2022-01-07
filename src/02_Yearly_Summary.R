

# Yearly summaries

YearlySummary <- DailyMail %>%
  group_by(Year) %>%
  summarize(sumReceived=sum(MailReceived, na.rm=T),
            sumSent=sum(MailSent, na.rm=T),
            meanReceived=mean(MailReceived, na.rm=T),
            meanSent=mean(MailSent, na.rm=T))
 
YearlySummary <- YearlySummary %>%
  filter (Year>2018 & Year<2022) %>%
  mutate(Yearc=factor(Year))


# Create Line Graph -------------------------------------------------------


ggplot(YearlySummary) +
  geom_segment( aes(x=Year, xend=Year, y=0, yend=sumReceived), color="orange") +
  geom_point( aes(x=Year, y=sumReceived), color="orangered", size=4, alpha=0.8) +
  geom_text(aes(x=Year, y=sumReceived+800, label=comma(sumReceived)))+
  theme_minimal()+
  xlab("")+
  ylab("Email Received")+
  labs(title="Yearly Email Received")+
  scale_x_continuous(breaks=seq(2019, 2021, 1))+ 
   scale_y_continuous(labels = comma)

ggsave("output/Yearly_Received_Summary.png", h=4, w=6)

ggplot(YearlySummary) +
  geom_segment( aes(x=Year, xend=Year, y=0, yend=sumSent), color="orange") +
  geom_point( aes(x=Year, y=sumSent), color="orangered", size=4, alpha=0.8) +
  geom_text(aes(x=Year, y=sumSent+300, label=comma(sumSent)))+
  theme_minimal()+
  xlab("")+
  ylab("Email Sent")+
  labs(title="Yearly Email Sent")+
  scale_x_continuous(breaks=seq(2019, 2021, 1))+ 
  scale_y_continuous(labels = comma)

ggsave("output/Yearly_Sent_Summary.png", h=4, w=6)

