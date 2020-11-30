#W2
#Data: https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip

pollutantmean <- function(directory, pollutant, id=1:332){
    sm <- 0
    n <- 0
    for(i in id){
        df <- read.csv(paste(directory, "/", sprintf("%03d", i), ".csv", sep=""))
        d <- na.omit(df[[pollutant]])
        sm <- sum(sm, d)
        n <- n + length(d)
    }
    sm / n
}

pollutantmean("specdata", "nitrate")

pollutantmean <- function(directory, pollutant, id=1:332){
    df <- data.frame()
    for(i in id){
        df <- rbind(df, read.csv(paste(directory, "/", sprintf("%03d", i), ".csv", sep="")))
    }
    mean(df[[pollutant]], na.rm = TRUE)
}

pollutantmean("specdata", "nitrate")

pollutantmean <- function(directory, pollutant, id=1:332){
    v <- rowSums(sapply(id, function(i) {
        df <- read.csv(paste(directory, "/", sprintf("%03d", i), ".csv", sep=""))
        d <- na.omit(df[[pollutant]])
        c(sum(d), length(d))
    }))
    v[1] / v[2]
}
pollutantmean("specdata", "nitrate")

complete <- function(directory, id=1:332){
    cc <- c()
    for(i in id){
        d <- read.csv(paste(directory, "/", sprintf("%03d", i), ".csv", sep=""))
        d <- d[complete.cases(d), ]
        cc <- c(cc, nrow(d))
    }
    data.frame(id=id, nobs=cc)
}
complete("specdata")

corr <- function(directory, threshold=0){
    cv <- c()
    df <- complete(directory)
    for(i in df$id){
        if(df[i,]["nobs"] > threshold){
            d <- read.csv(paste(directory, "/", sprintf("%03d", i), ".csv", sep=""))
            d <- d[complete.cases(d), ]
            cv <- c(cv, cor(d$nitrate, d$sulfate))            
        }
    }
    cv
}


library(datasets)
data("iris")
data("mtcars")
s <- split(iris, iris$Species)
sapply(s, function(x) mean(x[, c('Sepal.Length')]))
apply(iris[, 1:4], 2, mean)
with(mtcars, tapply(hp, cyl, mean))

set.seed(1)
rpois(5, 2)

#W3
#Data: https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip

hospital <- read.csv("hospital-data/outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])
best <- function(state, outcome){
    hout <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    n <- hout[outcome]
    if(is.na(n)){
        stop("invalid outcome")
    }
    d <- hospital[hospital$State==state, ]
    if(is.na(d)){
        stop("invalid state")
    }
    d <- d[, c(2, n)]
    d[, 2] <- as.numeric(d[, 2])
    d <- d[complete.cases(d), ]
    d <- d[order(d[, 2], d[, 1]), ]
    d$Hospital.Name[1]
}
best("TX", "heart failure")

rankhospital <- function(state, outcome, num = "best"){
    hout <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    n <- hout[outcome]
    if(is.na(n)){
        stop("invalid outcome")
    }
    d <- hospital[hospital$State==state, ]
    if(is.na(d)){
        stop("invalid state")
    }
    d <- d[, c(2, n)]
    d[, 2] <- as.numeric(d[, 2])
    d <- d[complete.cases(d), ]
    d <- d[order(d[, 2], d[, 1]), ]
    if(num == "best")    head(d$Hospital.Name, 1)
    else if(num == "worst")    tail(d$Hospital.Name, 1)
    else d$Hospital.Name[num]
}
rankhospital("TX", "heart failure", "best")

rankall <- function(outcome, num = "best"){
    hout <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    n <- hout[outcome]
    if(is.na(n)){
        stop("invalid outcome")
    }
    d <- hospital[, c(7, 2, n)]
    d[, 3] <- as.numeric(d[, 3])
    d <- d[complete.cases(d), ]
    d <- split(d, d$State)
    d <- do.call(rbind, lapply(d, function(x){
        x <- x[order(x[, 3], x[, 2]), 1:2]
        if(num == "best")    head(x, 1)
        else if(num == "worst")    tail(x, 1)
        else x[num, ]
    }))
    colnames(d) <- c("state", "hospital")
    d
}
rankall("heart attack")
best("AK", "pneumonia")
rankhospital("NY", "heart attack", 7)
r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)


