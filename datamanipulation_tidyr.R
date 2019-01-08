#Now, we will use read.csv() function to import the file,
mydata<-read.csv(file.choose(),header = T,sep = ",")
mydata<-read.csv("file:///D:/machine learning and ibm watson,cognos/allelectronics.csv",
                 header = TRUE,stringsAsFactors = TRUE)
View(mydata)
str(mydata)
#vector and matrix operations
# Creating random matrix with two 3x3 and one 4x3 dimension
# we will use runif() function to generate random number from
# standard uniform distribution
set.seed(1234) # To make the result reproducible
matA <- matrix(rnorm(12),ncol=3)
matB <- matrix(rnorm(9),ncol=3)
matB2 <- matrix(runif(9),ncol=3)
matB + matB2

'''dplyr
data.table
ggplot2
reshape2
readr
tidyr
lubridate
'''
#install.packages("dplyr")
library(dplyr)

data("mtcars")
data('iris')
mydata <- mtcars
#creating a local dataframe. Local data frame are easier to read

 mynewdata <- tbl_df(mydata)
 myirisdata <- tbl_df(iris)
 #use filter to filter data with required condition
 filter(mynewdata, cyl > 4 & gear > 4 )
 filter(mynewdata, cyl > 4)
 #use select to pick columns by name
  select(mynewdata, cyl,mpg,hp)
  #here you can use (-) to hide columns
 select(mynewdata, -cyl, -mpg ) 
 #hide a range of columns
 select(mynewdata, -c(cyl,mpg))
 #chaining or pipelining - a way to perform multiple operations
 #in one line
 
   ad_16<-function(x){
   sum(x+16)
    }
  sqr<-function(x)
    {
      sqrt(x)
      }
  sqr(ad_16(9))
 
 #install the dplyr
  z<-9%>% ad_16()%>%sqr()
  z
 
 mynewdata %>%
   select(cyl, wt, gear)%>%
   filter(wt > 2)
 
 #arrange can be used to reorder rows
 mynewdata%>%
   select(cyl, wt, gear)%>%
   arrange(wt)
#mutate - create new variables
 
 mynewdata %>%
   select(mpg, cyl)%>%
   mutate(newvariable = mpg*cyl)
 #summarise - this is used to find insights from data
  myirisdata%>%
   group_by(Species)%>%
   summarise(Average = mean(Sepal.Length, na.rm = TRUE))
  
  summary(iris)
  ##===============================
  #dataTable
  #load data
data("airquality")
mydata <- airquality
head(airquality,6)
data(iris)
myiris <- iris 
install.packages("data.table")
library(data.table)
mydata <- data.table(mydata)
mydata
myiris <- data.table(myiris)
myiris
#select columns with particular values
 myiris[Species == 'setosa']
 
 
 library(ggplot2)
 install.packages("gridExtra")
  library(gridExtra)
 library(dplyr)
  df <- ToothGrowth

df
df$dose <- as.factor(df$dose)
 head(df)
plot.default(iris$Sepal.Length~iris$Petal.Length)
str(df)
bp <- ggplot(df, aes(x = dose, y = len, color = dose)) + geom_boxplot() + theme(legend.position = 'none')
bp
sp <- ggplot(mpg, aes(x = cty, y = hwy, color = factor(cyl)))+geom_point(size = 2.5)
 sp
 
 #reshape2 Package'
 install.packages("reshape2")
 library(reshape2)]
library(data.table)
 #create a data
  ID <- c(1,2,3,4,5)
 Names <- c('Joseph','Matrin','Joseph','James','Matrin')
 DateofBirth <- c(1993,1992,1993,1994,1992)
 Subject<- c('Maths','Biology','Science','Psycology','Physics')
 thisdata <- data.frame(ID, Names, DateofBirth, Subject)
 data.table(thisdata)
 #This function converts data from wide format to long format. It's a form of 
 #restructuring 
 #where multiple categorical columns are 'melted' into unique rows. 
 mt <- melt(thisdata, id=(c('ID','Names')))
 mt
 
 
 
library(tidyr)
library(dplyr)
 View(mtcars)
head(mtcars)
mtcars$car <- rownames(mtcars)
names(mtcars)
mtcars <- mtcars[, c(12, 1:11)]
#gather==>gather - converts wide data to longer format
#syntax
#gather(data, key, value, ..., na.rm = FALSE, convert = FALSE)
mtcarsNew <- mtcars %>% gather(attribute, value, -car)
head(mtcarsNew)
tail(mtcarsNew)

## the great thing with tidyr() is u can select the certain columns other u can leave
mtcarsNew <- mtcars %>% gather(attribute, value, mpg:gear)
head(mtcarsNew)
tail(mtcarsNew)
#spread - converts long data to wider format
mtcarsSpread <- mtcarsNew %>% spread(attribute, value)
head(mtcarsSpread)
#unite - combines two or more columns into a single column
set.seed(1)
date <- as.Date('2016-01-01') + 0:14
hour <- sample(1:24, 15)
min <- sample(1:60, 15)
second <- sample(1:60, 15)
event <- sample(letters, 15)
data <- data.frame(date, hour, min, second, event)
data


dataNew <- data %>%
  unite(datehour, date, hour, sep = ' ') %>%
  unite(datetime, datehour, min, second, sep = ':')
dataNew

# seperate -- splits the column into two or more columns
data1 <- dataNew %>% 
  separate(datetime, c('date', 'time'), sep = ' ') %>% 
  separate(time, c('hour', 'min', 'second'), sep = ':')
data1
#DATES
 install.packages('lubridate')
 library(lubridate)
 #current date and time
  now()
  #assigning current date and time to variable n_time
   n_time <- now()
   n_time
  
   
    n_update <- update(n_time, year = 2013, month = 10)
   n_update   
