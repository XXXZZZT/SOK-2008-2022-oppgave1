#Datasettet inneholder informasjon om generC8siteten av forldrepermisjonsordninger og mC8dres yrkesdeltakelse i 24 OECD-land i 2021
# Foreldrepermisjonene varierer mellom land. 
# For C% gjC8re ulike landers rettigheter sammenlignbare presenteres permisjonsordningers gunstighet
# ved hjelp av "full rate equivalent":
# Uker med 100% stC8tte  = Foreldrepermisjonens varighet i uker * utbetalingssats (i prosent av gjennomsnittlig inntekt) 

library(tidyverse)
library(lubridate)
library(janitor)
library(ggplot2)


getwd

setwd("C:/Users/marti/Downloads")

women<-read.csv2("women.csv")

women$tot_full_rate<-as.numeric(women$tot_full_rate)
women$fem_emp_rate_0_2<-as.numeric(women$fem_emp_rate_0_2)
women$fem_emp_rate_6_14<-as.numeric(women$fem_emp_rate_6_14)


library(ggplot2)
  women %>%
  ggplot(aes(x=tot_full_rate,y=fem_emp_rate_0_2))+
  geom_point()+
  ylim(0, 100)+
  labs(x ="Uker med 100% stC8tte", y = "Yrkesdeltakelse blant m??dre hvis yngste barn er 0-2 ??r")+
  geom_smooth(method=lm, se=FALSE) -> kids_0_2

women%>%
  ggplot(aes(x=tot_full_rate,y=fem_emp_rate_6_14))+
  geom_point()+
  ylim(0, 100)+
  labs(x ="Uker med 100% stC8tte", y = "Yrkesdeltakelse blant m??dre hvis yngste barn er 6-14 ??r")+
  geom_smooth(method=lm, se=FALSE) -> kids_6_14

library(gridExtra)
library(grid)
grid.arrange(kids_0_2,kids_6_14, nrow = 1,  top = textGrob("Sammenhengen mellom foreldrepermisjons lengde og mC8dres yrkesdelakelse etter yngste barns alder",gp=gpar(fontsize=20,font=3)))

