## ----setup, cache=FALSE,echo=FALSE---------------------------------------
library("ggplot2")
library("RCurl") #To download stuff directly from the GitHub repo
library(e1071) # for skewness and kurtosis
# Now download stuff from noisy-ga repo
made.data <- read.csv(text = getURL("https://raw.githubusercontent.com/JJ/noisy-ga/master/data/MADE/made-data.csv"))
pacman.data <-  read.csv(text = getURL("https://raw.githubusercontent.com/JJ/noisy-ga/master/data/ms-pacman/pacman-fitness.csv"))
planetwars.data <- read.csv(text = getURL("https://raw.githubusercontent.com/JJ/noisy-ga/master/data/planet-wars/planetwars-fitness.csv"))

## ----made,cache=FALSE,echo=FALSE,warning=FALSE---------------------------
s.k <- data.frame(Gen=character(), 
                  Skewness=character(),
                  Kurtosis=character(),
                  stringsAsFactors=FALSE)

for ( i in c(64,128,256)) {
    for ( j in unique(subset(made.data,Gen==i)$ID) ) {
        this.data <- subset(made.data,Gen==i & ID==j)$Fitness
        s.k <- rbind( s.k
                     , data.frame(Gen=paste("Gen",i)
                                  ,Skewness=skewness(this.data)
                                  ,Kurtosis=kurtosis(this.data)))
    }
}

ggplot(s.k,aes(x=Skewness,y=Kurtosis,color=Gen))+geom_point()+scale_x_continuous(limits=c(-1,2.5))+scale_y_continuous(limits=c(-1,8))


## ----planetwars,cache=FALSE,echo=FALSE,warning=FALSE---------------------
pw.s.k <- data.frame(Gen=character(), 
                  Skewness=character(),
                  Kurtosis=character(),
                  stringsAsFactors=FALSE)

for ( i in c(1,50)) {
    for ( j in unique(subset(planetwars.data,Gen==i)$ID) ) {
        this.data <- subset(planetwars.data,Gen==i & ID==j)$Fitness
        pw.s.k <- rbind( pw.s.k
                     , data.frame(Gen=paste("Gen",i)
                                  , Skewness=skewness(this.data)
                                  , Kurtosis=kurtosis(this.data)))
    }
}

ggplot(pw.s.k,aes(x=Skewness,y=Kurtosis,color=Gen))+geom_point()+scale_x_continuous(limits=c(-1,2.5))+scale_y_continuous(limits=c(-1,8))

## ----pacman,cache=FALSE,echo=FALSE,warning=FALSE-------------------------
pm.s.k <- data.frame(Gen=character(), 
                  Skewness=character(),
                  Kurtosis=character(),
                  stringsAsFactors=FALSE)

for ( i in c(1,25,50)) {
    for ( j in unique(subset(pacman.data,Gen==i)$ID) ) {
        this.data <- subset(pacman.data,Gen==i & ID==j)$Fitness
        pm.s.k <- rbind( pm.s.k
                        , data.frame(Gen=paste("Gen",i)
                                     , Skewness=skewness(this.data)
                                     , Kurtosis=kurtosis(this.data)))
    }
}

ggplot(pm.s.k,aes(x=Skewness,y=Kurtosis,color=Gen))+geom_point()+scale_x_continuous(limits=c(-2,10))+scale_y_continuous(limits=c(-5,100))

