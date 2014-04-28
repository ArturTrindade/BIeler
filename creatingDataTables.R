rm(list=ls())
require(compiler)
require(xts)
Sys.setenv(TZ="UTC")
readDir<-"C:/Users/Artur/Documents/GitHub/BIeler/Dados/2013/13/5/1"
saveDir<-"C:/Users/Artur/Desktop/tabelas/"

###this function creates a table reading preselected columns from all csv files in a folder
criarTabelasDados<-function(readDir,saveDir){
  
  if(length(list.dirs(readDir,recursive=FALSE))==0){
    if(length(list.files(readDir))==0){
      #### if empty directory do nothing
      print("empty directory")
    }
    else{
      dados<-matrix(0,ncol=length(list.files(readDir))+1,nrow=nrow(read.csv(
        header=TRUE,list.files(readDir,full.names=TRUE)[1],sep=";")))
      dados<-as.data.frame(dados)
      dados[[1]]<-as.POSIXct(read.csv(header=TRUE,list.files(readDir
        ,full.names=TRUE)[1],sep=";")[,1], format = "%d-%m-%Y %Hh%M", tz = "UTC")
      dados <- xts(dados[,2:ncol(dados)], order.by=dados[,1],tzone='UTC')
      print(readDir)
      print(saveDir)
      
      for(i in 1:length(list.files(readDir))){
      dados[,i]<-read.csv(header=TRUE,
                            list.files(readDir,full.names=TRUE)[i],sep=";")[,2]
        
      }
#       write.csv(dados,paste(saveDir,"dados.csv",sep=""))
    }
    
  }  
  
  else{
#     print("STOP")
    for(i in 1:length(list.dirs(readDir,recursive=FALSE))){
      saveDirtemp<-paste(saveDir,i,"/",sep="")
      print(paste("dir",i,sep="_"))
      if(!file.exists(saveDirtemp)){
        dir.create(saveDirtemp)
      }
      
      criarTabelasDados(list.dirs(readDir,recursive=FALSE)[i],saveDirtemp)
      
    }
  }
  return(dados)
}
criarTabelasDados <- cmpfun(criarTabelasDados)
dados<-criarTabelasDados(readDir,saveDir)
