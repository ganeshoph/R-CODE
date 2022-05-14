library(RMySQL)
mydb <- dbConnect(RMySQL::MySQL(),
                  host = "35.241.99.163",
                  dbname = "bifrost",
                  port = 3306 ,
                  user = "ganesh@lvpei.org",
                  password = "ganeshsgmoid123")
#dbListTables(mydb)
#dbListFields(mydb, "comments")
datatable <- dbReadTable(mydb, "dme")
#head(datatable)
#dbListFields(mydb, "dr")
# cat(paste("Completed-Reading comments table",sep = ""))
# Sys.sleep(.09)
datatable1 <- dbReadTable(mydb, "dr")
#head(datatable1)
#dbListFields(mydb, "gradeability")
# cat(paste("Completed-Reading DR table",sep = ""))
# Sys.sleep(.09)
datatable2 <- dbReadTable(mydb, "gradeability")
#head(datatable2)
#dbListFields(mydb, "medical_image_detector")
# cat(paste("Completed-Reading gradability table",sep = ""))
# Sys.sleep(.09)
datatable3 <- dbReadTable(mydb, "medical_image_detector")
#head(datatable3)
#dbListFields(mydb, "upload")
# cat(paste("Completed-Reading medical image detector table",sep = ""))
# Sys.sleep(.09)
datatable4 <- dbReadTable(mydb, "upload")
#head(datatable4)
# cat(paste("Completed-Reading upload table",sep = ""))
# Sys.sleep(.09)
datatable5 <- dbReadTable(mydb, "real_upload")
#head(datatable5)
# cat(paste("Completed-Reading upload1 table",sep = ""))
# Sys.sleep(.09)
datatable6 <- dbReadTable(mydb, "artifacts")
#head(datatable6)
# cat(paste("Completed-Reading artifacts table",sep = ""))
# Sys.sleep(.09)
datatable7 <- dbReadTable(mydb, "focus")
#head(datatable7)
# cat(paste("Completed-Reading focus table",sep = ""))
# Sys.sleep(.09)
datatable8 <- dbReadTable(mydb, "illumination")
#head(datatable8)
# cat(paste("Completed-Reading illuminaion table",sep = ""))
# Sys.sleep(.09)
library(lubridate)
datatable4$date<-as_date(datatable4$default_timestamp)
#datatable4$default_timestamp<-as.POSIXct(datatable4$default_timestamp)
# cat(paste("Completed-Converting date coloumn",sep = ""))
# Sys.sleep(.09)
library(data.table)
finaltable<-merge.data.table(datatable4,datatable3, by = "image_filename", all.x = T)
finaltable<-merge.data.table(finaltable,datatable8, by = "image_filename", all.x = T)
finaltable<-merge.data.table(finaltable,datatable7, by = "image_filename", all.x = T)
finaltable<-merge.data.table(finaltable,datatable6, by = "image_filename", all.x = T)
finaltable<-merge.data.table(finaltable,datatable2, by = "image_filename", all.x = T)
finaltable<-merge.data.table(finaltable,datatable1, by = "image_filename", all.x = T)
#finaltable<-merge.data.table(finaltable,datatable5, by = "image_filename", all.x = T)
finaltable<-merge.data.table(finaltable,datatable, by = "image_filename", all.x = T)
finaltable<-subset(finaltable,finaltable$username!="sgmoid@lvpei.org")
finaltable<-subset(finaltable,finaltable$username!="SGMOID@lvpei.org")
finaltable<-subset(finaltable,finaltable$username!="pranav@lvpei.org")
finaltable<-subset(finaltable,finaltable$username!="pranag@lvpei.org")
finaltable<-subset(finaltable,finaltable$username!="u64103")
finaltable<-subset(finaltable,finaltable$username!="smuralikrishna@lvpei.org")
finaltable<-subset(finaltable,finaltable$username!="vijaykumar@lvpei.org")
finaltable<-finaltable[order(finaltable$date),]
#finaltable<-finaltable[1:(length(finaltable$image_filename)-78),]
#head(finaltable)
#tail(finaltable)
library(tidyverse)

#







cat(paste("Completed-Merging to final table",sep = ""))
Sys.sleep(.09)
gaba<-readLines('c:/Users/Ganesh/Documents/sgmoid.txt')
if (gaba != finaltable$image_filename[length(finaltable$image_filename)]) {
  TEMP<-which(grepl(gaba,finaltable$image_filename))
  F<-as.numeric(TEMP)+1
  T<-length(finaltable$image_filename)
  #T<-which(grepl(as_date(Sys.Date()),finaltable$date))
  #T<-T[1]-32
  finaltable1<-finaltable[F:T,]
  FILENAME<-paste("\\\\172.16.154.92\\Images\\BIFROST\\LIVE\\livesigmoid_ ",as_date(Sys.Date()),".csv",sep = "")
  lastfilename<-length(finaltable1$image_filename)
  cat(finaltable1$image_filename[lastfilename],sep = "",file = 'c:/Users/Ganesh/Documents/sgmoid.txt')
  #Sys.sleep(4)
  #writeClipboard(finaltable1$file_path)
  #Sys.sleep(4)
  #write.csv(finaltable1$file_path,paste("\\\\172.16.154.92\\Images\\BIFROST\\LIVE\\sigmoidlinks_",as_date(Sys.Date()),".txt",sep = ""),row.names = FALSE)
  #write.table(finaltable1$file_path,paste("\\\\172.16.154.92\\Images\\BIFROST\\LIVE\\Links\\sigmoidlinks_",as_date(Sys.Date()),".txt",sep = ""),row.names = FALSE,col.names = FALSE)
  cat(paste("Completed- making all files & process",sep = ""))
  Sys.sleep(4)
  z<-finaltable1$file_path
  library(utils)
  for (i in 1:length(z)) {
    download.file(z[i],destfile = paste("d:/sgmoidliveimages/",basename(z[i]),sep = ""), mode = 'wb')
    #file.copy(z[i],'d:/dummy/')
  }
  #setwd("D:/sgmoidliveimages/")
  #downimages<-list.files(path = "D:/sgmoidliveimages/", pattern = "jpg")
  #i<-3
  #for (i in 1:length(downimages)) {
  #  F1<-gsub("%3A","",downimages[i])
  #  file.rename(downimages[i],F1)
  #}




  #####  CODE for finding duplicates



  library("digest")
  test_dir<- "D:/sgmoidliveimages/"
  filelist <- list.files(test_dir, pattern = "JPG|jpg|jpeg|png|PNG", recursive=TRUE, all.files =TRUE, full.names=TRUE)
  sfilelist <- list.files(test_dir, pattern = "JPG|jpg|jpeg|png|PNG", recursive=TRUE, all.files =TRUE, full.names=FALSE)
  # a concise, vectorized solution
  # http://stackoverflow.com/questions/14060423/how-to-vectorize-this-r-code-using-plyr-apply-or-similar
  datatable.temp<-data.frame(matrix(ncol = 2))
  names(datatable.temp)<-c("image_filename","md5")
  for (i in 1:length(filelist)) {
    md5<-digest(filelist[i], algo = "md5", file = TRUE)
    datatable.temp[i,1]<-sfilelist[i]
    datatable.temp[i,2]<-md5
  }
  datatable5.temp<-datatable.temp[!duplicated(datatable.temp$md5),]
  datatable5.temp$uni_dup<-"UNIQUE"
  datatable5<-datatable.temp
  datatable5<-merge.data.frame(datatable5,datatable5.temp, by = "image_filename", all.x = T)
  datatable5<-subset(datatable5,select = c(image_filename,uni_dup))
  datatable5[is.na(datatable5$uni_dup),2]<-"DUPLICATE"



  finaltable1<-merge.data.table(finaltable1,datatable5, by = "image_filename", all.x = T)

  write.csv(finaltable1,FILENAME)

}

cat(paste("Completed-ALL PROCESS QITTING NOW..........",sep = ""))
Sys.sleep(4)






