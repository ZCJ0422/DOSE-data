library(readr)
library(stringr)
DISEASE_ALLIANCE_HUMAN <- read_delim("./DISEASE-ALLIANCE_HUMAN.tsv", 
                                     delim = "\t", escape_double = FALSE, 
                                     comment = "#", trim_ws = TRUE)

#DO2GE.rda的生成
GeneDoid<-data.frame(DISEASE_ALLIANCE_HUMAN$DBObjectID,DISEASE_ALLIANCE_HUMAN$DOID)
names(GeneDoid)<-c("gene","doid")
GeneDoid$gene<-str_sub(GeneDoid$gene,6)

a<-unique(GeneDoid$doid)
k=nrow(GeneDoid)
mylist<-vector("list",length(a))
c=1

for (i in a){
  for (j in 1:k){
    if(i==GeneDoid$doid[j]){
      mylist[[c]]=append(mylist[[c]],GeneDoid$gene[j])
    }
  }
 names(mylist)[c]<-i
 c=c+1
}

DO2EG<-mylist
save(DO2EG,file = "./DO2EG.rda",compress = "xz")



#GE2DO.rda的生成
GeneDoid<-data.frame(DISEASE_ALLIANCE_HUMAN$DBObjectID,DISEASE_ALLIANCE_HUMAN$DOID)
names(GeneDoid)<-c("gene","doid")
GeneDoid$gene<-str_sub(GeneDoid$gene,6)

a<-unique(GeneDoid$gene)
k=nrow(GeneDoid)
mylist<-vector("list",length(a))
c=1

for (i in a){
  for (j in 1:k){
    if(i==GeneDoid$gene[j]){
      mylist[[c]]=append(mylist[[c]],GeneDoid$doid[j])
    }
  }
  names(mylist)[c]<-i
  c=c+1
}

EG2DO<-mylist
save(EG2DO,file = "./EG2DO.rda",compress = "xz")
