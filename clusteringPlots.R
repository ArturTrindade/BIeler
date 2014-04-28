# png('C:/Users/Artur/Documents/GitHub/BIeler/nov_hp1.png',width = 1366, height = 768, units = "px", pointsize = 23,bg ="transparent")

par(mar=c(4,4,2,4))

ini<-'2013-02-17 00:00:00'
days<-7
x<-paste(as.Date(ini)," 00:00:00/",as.Date(ini)+days-1," 23:45:00",sep="")
plot.xts(dados[x,1]/mean(dados[,1]), ylim=c(.25,2),main='hp1')
for(i in 2:ncol(dados)){
  lines(dados[x,i]/mean(dados[,i]),cex=.75,col=i,lwd=1)
}
legend("topleft",paste("hp1.",seq(1,ncol(dados)),sep=""),col=c("black",seq(2, ncol(dados), by = 1)),ncol=ncol(dados),lwd=1)

# dev.off()
