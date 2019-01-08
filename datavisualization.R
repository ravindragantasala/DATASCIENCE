#Data Visualization with ggplot2
#bivariate analysis
#scatterplots
attach(iris)
View(iris)
table(iris$Species)
library(ggplot2)
plot.default(iris$Sepal.Length~iris$Petal.Length)
#adding the lables to the plot
plot(iris$Sepal.Length~iris$Petal.Length,ylab = "sepalLength",xlab="petalLength",
     main="sepalLength vs petalLlength")
#adding colors to the plot
plot(iris$Sepal.Length~iris$Petal.Length,ylab = "sepalLength",xlab="petalLength",
     main="sepalLength vs petalLength",col="blue",pch=16)



#univariate analysis
#just one variable is examined
#Histograms
hist(iris$Sepal.Width)
#adding color and labels to the hist
hist(iris$Sepal.Width,ylab = "SepalWidth",main = "distribution of sepalwidth",
     col = "aquamarine3")

#Box plots
boxplot(iris$Sepal.Length~iris$Species)
#adding colors
boxplot(iris$Sepal.Length~iris$Species, ylab="sepalLength",xlab="species",
        main ="sepalLength of differnt species",col="burlywood")
#---------------------------------------------------------------------------
#ggplot2
library(ggplot2)
#1 selection of data
ggplot(data = iris)
ggplot(data = iris,aes(y=Sepal.Length,x=Petal.Length))
ggplot(data = iris,aes(y=Sepal.Length,x=Petal.Length))+geom_point()
#----------------------------------
#Aesthetics 
ggplot(data = iris,aes(y=Sepal.Length,x=Petal.Length,col = Species))+geom_point()
ggplot(data = iris,aes(y=Sepal.Length,x=Petal.Length,shape = Species))+geom_point()
ggplot(data = iris,aes(y=Sepal.Length,x=Petal.Length,col = Species,
                       shape = Species))+geom_point()
#----------------
#play with the geometric
dbts<-read.csv("file:///C:/Users/ravindragantasala/insurance.csv",
               stringsAsFactors=FALSE)
View(dbts)
#datasets::iris
#head(AirPassengers)
ggplot(data = dbts,aes(x=bmi))+geom_histogram()
ggplot(data = dbts,aes(x=bmi))+geom_histogram(bins = 50)
ggplot(data = dbts,aes(x=bmi))+geom_histogram(bins = 50,fill ="palegreen4")
ggplot(data = dbts,aes(x=bmi))+geom_histogram(bins = 50,fill="palegreen4",col="red")
#fill as aesthetic
ggplot(data = dbts,aes(x=bmi,fill =age))+geom_histogram()
ggplot(data = dbts,aes(x=bmi,fill =sex))+geom_histogram(position = "fill")
# bar plots
ggplot(data = dbts,aes(x=region))+geom_bar()
ggplot(data = dbts,aes(x=sex,fill=smoker ))+geom_bar(position = "fill")

#frequency polygon
ggplot(data = dbts,aes(x=age))+geom_freqpoly()
ggplot(data = dbts,aes(x=age))+geom_freqpoly(bins =10)
ggplot(data = dbts,aes(x=age,col=smoker ))+geom_bar(bins =10)

#boxplots
ggplot(data = iris,aes(x=Species,y=Sepal.Length))+geom_boxplot()
