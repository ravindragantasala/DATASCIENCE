
# Data Management using R Libraries(Apply,Dplyr,data.table)

# using apply group of functtions
# apply
# by
# eapply
# lapply
# mapply
# rapply
# sapply
# tapply
mtcars
View(mtcars)
edit(mtcars)
m <- matrix(c(1:10,11:20), nrow=5, ncol=4)

m

# compute average for all the columns
apply(m,2,mean)

# compute average for all the rows
apply(m,1,mean)

# creating custom functions and apply it over columns and rows
apply(m, 1:2, function(x) x^2)

# by function
class(mtcars)
head(mtcars)

names(mtcars)

#compute the aveerage mileage by cylnder type
by(mtcars[,-2], mtcars$cyl, colMeans)

#by function for categorical variables
by(mtcars[,c(1,5)], factor(mtcars$cyl), colMeans)

# eapply function
# computes the statistical function by an environment
e <- new.env()
e$a <- 1:100
e$b <- 2003:2300


mean(e) # this is erroneous

eapply(e, mean) # applies function to each of the elements in a list

# lapply is applicable when your input is a list and 
#it also returns output as a list
mylist<- as.list(mtcars)
head(mylist)

lapply(mylist, median)

# sapply - similar to vapply
# sapply takes input as list/matrix and output is a vector
sapply(mylist, median)

# vapply
vapply(mylist, fivenum, c(min=0,'Q1'=0,median =0, 'Q3'=0, max=0))

# replicate function
replicate(5, rnorm(5, 100, 2), simplify=T)

#mapply
l1 <- list(mtcars[,1:4])
str(l1)
l2 <- list(mtcars[,3:8])
str(l2)
# sum of corresponding elements captured in L1 and L2
mapply(sum, x=l1,y=l2)

# rapply
rapply(mtcars[,1:3], log2, how='list')

#tapply function
tapply(mtcars$mpg, mtcars$cyl, mean)


library(ggplot2)
head(diamonds)
#Assignment
# find the mean price of diamonds by cut
# find the variation in prices across color of the diamonds
# standardize the axis x,y and z, centering
# normalize the depth, table, carat variable
# print a summary statement of all the numeric columns

# Centering = X - mean(X)

# Standardization = (X - mean(X)) / sd(X)

# sweep function
df = as.matrix(mtcars[2:6,2:5])

rownames(df) <-NULL

avg<-apply(df,2,mean)

sweep(df,2,avg,"-")

sweep(df,2,apply(df,2,mean),"-")



# library Data.Table (open source tool)
# goals of data.table library is to process large datasets by doing
# reducing the programming time- fewer ffunctions, less variable repetition
# reducing the computation time- fast aggregation, update by referencing

library(data.table)

# SQL style of referencing
# R(Data.Table) : i               j                by
# SQL:           where           select           groupby

df = data.frame(mtcars[,1:5])

head(df)

library(data.table)
dt = data.table(mtcars[,1:5])

dt1 = data.table(mtcars[,1:5])

tables()

sapply(dt, class)



# dplyr usage and verbs there are 5 verbs
#1- filter
#2- select, contains, start with, end with
#3- arrange
#4- mutate
#5- summarise, groupby, summary by

library(dplyr)
library(ggplot2)

head(diamonds)

#install.packages("nycflights13")

# application of filter function
df <- filter(diamonds, cut=='Good')

head(df)

# application of filter function
df <- filter(diamonds, price > 326 & price < 400)

head(df);dim(df)

# select function
df <- select(diamonds, carat, cut, color, clarity, depth, price)

head(df)

# mutate function
df <- mutate(diamonds, per_carat_p = price/carat)

head(df)

# arrange function
df<-arrange(diamonds,price)

tail(df)

# arrange function
df<-arrange(diamonds,desc(price))

head(df)

#summarize function
summarize(diamonds, mean_price= mean(price, na.rm=T),
          median_price = median(price,na.rm = T))


#introduction to pipe operator
df <- diamonds %>% 
  filter(cut=="Ideal") %>% 
  select(carat, cut, color, price, clarity) %>% 
  mutate(price_per_c = price/carat)

head(df)

head(select(diamonds,-color))

head(select(diamonds,carat:table))

head(select(diamonds,starts_with("c")))

head(select(diamonds,ends_with("y")))

head(select(diamonds,contains("pth")))

head(filter(diamonds, price >= 1000))

head(filter(diamonds, price >= 1000, depth >= 60, carat >= 0.80))

head(filter(diamonds, cut %in% c("Good","Ideal")))

diamonds %>% select(price, table) %>% head

diamonds %>% arrange(desc(price)) %>% head

diamonds %>% summarise(median_price = median(price))

diamonds %>% 
  group_by(clarity) %>% 
  summarise(avg_price=mean(price), 
            avg_carat=mean(carat))

distinct(diamonds, color)

# let's install those libraries
library(dplyr)
library(nycflights13)
library(ggplot2)
head(flights)

by_day<-group_by(flights, day)
(daily_delay <- summarise(by_day, dep=mean(dep_delay, na.rm = T),
                          arr=mean(arr_delay, na.rm = T)))

daily_delay <- by_day %>% filter(!is.na(dep_delay)) %>%
  summarise(
    mean = mean(dep_delay),
    median = median(dep_delay),
    P75 = quantile(dep_delay, 0.75),
    Over_15 = mean(dep_delay > 15),
    Over_30 = mean(dep_delay > 30),
    Over_60 = mean(dep_delay > 60)
  )
qplot(day, P75, data= daily_delay)


sfo <- filter(flights, dest=="SFO")
head(sfo)


qplot(day, dep_delay, data=sfo)


qplot(day, arr_delay, data=sfo)


qplot(arr_delay, dep_delay, data=sfo)

qplot(dep_delay, data=flights, binwidth=100)

qplot(day, mean, data= daily_delay)

qplot(day, median, data= daily_delay)



qplot(day, Over_15, data= daily_delay)

# complex data manipulation scripts
hourly_delay <- filter(
  summarise(
    group_by(
      filter(flights, !is.na(dep_delay)),
      day, hour),
    delay = mean(dep_delay),
    n = n()),
  n > 10
)
hourly_delay

hourly_delay <- flights %>% filter(!is.na(dep_delay)) %>%
  group_by(day, hour) %>% summarise(
    delay = mean(dep_delay),
    n =n()
  ) %>% filter(n>750)
hourly_delay

dim(flights)
names(flights)

flights %>% 
  group_by(dest) %>% 
  summarise(arr_delay = mean(arr_delay, na.rm=T), n=n()) %>%
  arrange(desc(arr_delay))


flights %>% 
  group_by(carrier, flight, dest) %>%
  tally(sort=T) %>% 
  filter(n==200)

flights %>% 
  group_by(carrier, flight, dest) %>%
  filter(n()==200)


per_hour <- flights %>%
  mutate(time= hour+minute / 60) %>% 
  group_by(time) %>%
  summarise(arr_delay = mean(arr_delay, na.rm=T), n= n())
per_hour
# Dataset
library(nycflights13)


# Assignment
#1- select all the records where the flight month was January
library(dplyr)
df<-filter(hflights,Month==1)
head(df);
dim(df)[1]
#2- show me top 10 records where the data were summarised by year, month and dayof month
df <- arrange(hflights, DayofMonth, Month, Year)
head(df,10)
dim(df)

#3- print top 10 delayed flights record
df = arrange(hflights,desc(DepDelay))
head(df,10)

#4- compute the speed and delay of all flights
df = mutate(hflights, delay= ArrDelay - DepDelay,
            speed = Distance/AirTime*60)
head(df)
#5- is mean departure delay is equal to mean arrival delay
summarize(hflights,mean(DepDelay,na.rm = T))==summarize(hflights,mean(ArrDelay,na.rm = T))



#Library Data.table ; Data Management
require(data.table)
library(data.table)

head(mtcars,10)

dt <- data.table(mtcars)[,.(cyl,gear)]

dt[,unique(gear),by=cyl]
table(dt$gear)

dt <- data.table(mtcars)[,.(cyl,gear)]
dt[,gearsL:=list(list(unique(gear))),by=cyl]

dt[,gearsL:=.(list(unique(gear))),by=cyl]
head(dt)

head(dt[,gearsL1:=lapply(gearsL, function(x) x[2])])
head(dt[,gearsS1:=sapply(gearsL, function(x) x[2])])

str(head(dt[,gearsL1]))

str(head(dt[,gearsS1]))

head(dt[,gearsL2:=lapply(gearsL, '[',2)])
head(dt[,gearsS2:=sapply(gearsL, '[',2)])


#calculate all the gears for all the cars of each cyl (excluding the current row)
head(dt[,other_gear:=mapply(function(x,y) setdiff(x,y),x=gearsL,y=gear)])


head(dt[,other_gear:=mapply(setdiff,gearsL,gear)])

dt <- data.table(mtcars)

dt[,{tmp1=mean(mpg); tmp2=mean(abs(mpg-tmp1));tmp3=round(tmp2,2)},by=cyl]

dt[,{tmp1=mean(mpg); tmp2=mean(abs(mpg-tmp1));tmp3=round(tmp2,2);list(tmp2=tmp2,tmp3=tmp3)},by=cyl]

dt[,tmp1:=mean(mpg), by=cyl][,tmp2:=mean(abs(mpg-tmp1)),by=cyl][by=cyl][,tmp1:=NULL]

#Fast Looping with set function
M = matrix(1,nrow=100000,ncol=100)
df = as.data.frame(M)
dt = as.data.table(M)

system.time(for (i in 1:1000) df[i,1L] <- i)
system.time(for (i in 1:1000) dt[i,V1:=i])

system.time(for (i in 1:1000) M[i,1L] <- i)


dt <- data.table(mtcars)[,1:5,with=F]
for (j in c(1L,2L,4L)) set(dt,j=j, value=-dt[[j]])
for (j in c(3L,5L)) set(dt,j=j, value=paste0(dt[[j]],'!!'))
head(dt)

#using shift for to lead/lag vectors and lists
dt <- data.table(mtcars)[,.(mpg,cyl)]
dt[,mpg_lag1:=shift(mpg,1)]
dt[,mpg_forward:=shift(mpg,1, type='lead')]
head(dt)

#create multiple columns using := in one statement
dt <- data.table(mtcars)[,.(mpg,cyl)]

head(dt[,':=' (ave = mean(mpg),med = median(mpg), 
               min = min(mpg), 
               max = max(mpg)),
        by = cyl])

dt <- data.table(mtcars)[,.(cyl,mpg)]

things2 <- "mpgdoubled"
head(dt[,(things2):= mpg*2])

#calculating a function over a group
# compute mean by cyl
dt <- data.table(mtcars)[,.(cyl,gear,mpg)]
head(dt[,mpg_mean:=mean(mpg),by=cyl])

dt[,dt[!gear %in% unique(dt$gear)[.GRP], mean(mpg),by=cyl],by=gear]
dt[gear!=4 & cyl ==6, mean(mpg)]

dt[,dt[!gear %in% .BY[[1]], mean(mpg),by=cyl],by=gear]

uid <- unique(dt$gear)
dt[,dt[!gear %in% (uid[.GRP]), mean(mpg),by=cyl],by=gear]

dt[,.GRP, by=cyl]

#seting primary key
setkey(dt,gear)
uid <- unique(dt$gear)
dt[,dt[!.(uid[.GRP]), mean(mpg),by=cyl],by=gear]

mean(dt[cyl==4 & gear!=3,mpg])
mean(dt[cyl==6 & gear!=3,mpg])

#suppressing the intermediate operations
dt[, .SD[,mean(mpg)],by=gear]

dt[, .SD[,mean(mpg),by=cyl],by=gear]

#nested data.tables and by statements
dt[,{
  vbar = sum(mpg)
  n = .N
  .SD[,.(n,.N, sum_in_gear_cyl = sum(mpg),sum_in_cyl=vbar),by=gear]
},by=cyl]

dt[,sum(mpg), by =cyl]


dt[,{
  vbar = mean(mpg)
  n = .N
  .SD[,(n*vbar - sum(mpg))/(n-.N),by=gear]
},by=cyl]

#fastest calculation of statistcs
dt<-data.table(mtcars)[,.(mpg,cyl,gear)]
head(dt)

dt[,':='(ve_mpg_cyl = mean(mpg),Ncyl = .N),by=cyl]

dt[,':='(Ncylgear = .N, ave_mpg_cyl_gear=mean(mpg)),by=.(cyl,gear)]

setkey(dt, cyl, gear)

head(dt)






















