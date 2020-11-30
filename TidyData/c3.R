download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "./comm-survey.csv")
dt <- read.csv("comm-survey.csv")
head(dt)
sum(na.omit(dt$VAL == 24))

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile = "./nga.xlsx")
library(xlsx)
dat <- read.xlsx2("nga.xlsx", sheetIndex = 1, startRow = 18, endRow = 23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)
dat

library(XML)
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
fi <- readLines(con)
nchar(fi[c(10, 20, 30, 100)])

x <- read.fwf(file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"), skip=4, widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
sum(x[1:1116, 4])
tail(x)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "./acs.csv")
df <- read.csv("acs.csv")
head(df)
which(df$ACR == 3 & df$AGS == 6)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "./gdp.csv")
library(tidyverse)
gdp <- read_csv("gdp.csv", na = c("", ".."))
gdp <- gdp[c(-1:-4),]
gdp <- select(gdp, c(1,2,4,5))
gdp <- rename(gdp, GDPR="Gross domestic product 2012", CountryCode=X1, GDP=X5)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "./edu.csv")
edu <- read_csv("edu.csv")
gdp <- gdp[!is.na(gdp$CountryCode),]
gdp <- gdp[!is.na(gdp$GDPR),]
gdp <- mutate(gdp, GDP=as.numeric(gsub(",", "", GDP)))
gdp <- mutate(gdp, GDPR=as.numeric(GDPR))
mean(gdp$GDP)
head(gdp,10)
m <- merge(gdp, edu)
m <- arrange(m, GDP)
head(m, 13)
nrow(m)
NROW(grep("^Fiscal year end: June", m$`Special Notes`))

gb <- group_by(m, `Income Group`)
head(gb)
summarise(gb, mean(GDPR))
library(Hmisc)
table(cut2(m$GDPR, g=5), m$`Income Group`)

# ?cut2 for summary

df <- read.csv("acs.csv")
head(df)
strsplit(colnames(df), "wgtp")

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
index(amzn)
sampleTimes = as.Date(index(amzn), "%Y-%m-%d")
head(sampleTimes)

library(lubridate)
NROW(sampleTimes[year(sampleTimes) == 2012 & wday(sampleTimes) == 2])
