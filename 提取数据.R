library(dplyr)
dat<-read.csv('dataaa.csv',header = TRUE)
temp<-summarise(group_by(dat,专家),
'num'=length(打分),'平均'=mean(打分),'标准差'=sqrt(sum((打分-mean(打分))^2)/length(打分)),'max'=max(打分),'min'=min(打分),'1stQ'=quantile(打分,0.25),'3rdQ'=quantile(打分,0.75))
temp<-data.frame(temp)
temp

temp$标准差
pingjun=mean(dat$打分)
fangcha=sum((dat$打分-pingjun)^2)/(1046*3)
#sink()
#creating the text
#sink(file="thisdata.txt")
#temp
#sink()
#end of creating

