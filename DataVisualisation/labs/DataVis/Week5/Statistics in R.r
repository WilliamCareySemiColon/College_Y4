
url <- "http://www.jaredlander.com/data/Tomato%20First.csv"
tomato <- read.table(file = url, header = TRUE, sep = ",")
head(tomato)

library(readr)
theUrl <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato2 <-read_delim(file=theUrl, delim=',')

library(data.table)
theUrl <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato3 <-fread(input=theUrl, sep=',', header=TRUE)

tomato3

download.file(url='http://www.jaredlander.com/data/ExcelExample.xlsx',
              destfile='./data/ExcelExample.xlsx', 
              method='libcurl')

library(readxl)
excel_sheets('./data/ExcelExample.xlsx')

wineXL1 <- read_excel('./data/ExcelExample.xlsx', sheet=2)
head(wineXL1)

download.file("http://www.jaredlander.com/data/diamonds.db",
              destfile = "./data/diamonds.db", mode='wb')

library(RSQLite)

#To connect to the database we first specify the driver using dbDriver. 
#The function’s main argument is the type of driver, such as “SQLite” or “ODBC”.

drv <- dbDriver('SQLite')
class(drv)

con <- dbConnect(drv, './data/diamonds.db')
class(con)

dbListTables(con)
dbListFields(con, name='diamonds')

longQuery <- "SELECT * FROM diamonds, DiamondColors WHERE diamonds.color = DiamondColors.Color"
diamondsJoin <-dbGetQuery(con, longQuery,stringsAsFactors=FALSE)
head(diamondsJoin)

dbDisconnect(con)

save(tomato3, file= "./data/tomato.rdata")
rm(tomato3)
#  Check if it still exist
head(tomato3)

load("./data/tomato.rdata")
# Check if it exist now
head(tomato3)

n <- 20
r <- 1:10
w <- data.frame(n,r)
# lets check them out
head(w)

# save them
save(n,r,w, file="./data/multiple.rdata")
# delete them
rm(n,r,w)
# now load them back from rdata
load("./data/multiple.rdata")
# print out n and r
n
r


require(ggplot2)
data(diamonds)
head(diamonds)

hist(diamonds$carat, main="Carat Histogram", xlab="Carat")

plot(price ~ carat, data = diamonds)

plot(diamonds$carat, diamonds$price)

boxplot(diamonds$carat)


p <-ggplot(data = diamonds) + geom_histogram(aes(x=carat))
p

ggplot(data=diamonds, aes(x=carat)) + geom_density(aes(x=carat))

ggplot(data=diamonds) + geom_density(aes(x=carat) , fill = "grey50")

g <- ggplot(diamonds, aes(x=carat,y=price))
g + geom_point(aes(color=color))

g + geom_point(aes(color=color)) + facet_wrap(~color)

g + geom_point(aes(color=color)) + facet_grid(cut~clarity)

ggplot(diamonds,aes(y=carat,x=1)) + geom_boxplot()

ggplot(diamonds,aes(y=carat,x=cut)) + geom_boxplot()

require(gridExtra)
p1 <- ggplot(diamonds,aes(y=carat,x=cut)) + geom_point() + geom_violin()
p2 <- ggplot(diamonds,aes(y=carat,x=cut)) + geom_violin() + geom_point()
grid.arrange(p1, p2, ncol=2)

require(ggplot2)
data(diamonds)
head(diamonds)

## Histogram using base graphics

hist(diamonds$carat, main="Carat Histogram", xlab="Carat")

## Scatterplot with base graphics
plot(price ~ carat, data = diamonds)


## Scatterplot without using formula


plot(diamonds$carat, diamonds$price)

## Boxplots with base graphics

boxplot(diamonds$carat)

## Histogram using ggplot2

ggplot(data = diamonds) + geom_histogram(aes(x=carat)) 

## Density plot using ggplot2

## Scatterplot using ggplot2


g <- ggplot(diamonds, aes(x=carat,y=price))
g + geom_point(aes(color=color))

## Facet_wrap and facet_grid in ggplot2

g + geom_point(aes(color=color)) + facet_wrap(~color)

g + geom_point(aes(color=color)) + facet_grid(cut~clarity)


## Boxplot using ggplot2


ggplot(diamonds,aes(y=carat,x=1)) + geom_boxplot()

ggplot(diamonds,aes(y=carat,x=cut)) + geom_boxplot()

## Violin Plots using ggplot2

require(gridExtra)
p1 <- ggplot(diamonds,aes(y=carat,x=cut)) + geom_point() + geom_violin()
p2 <- ggplot(diamonds,aes(y=carat,x=cut)) + geom_violin() + geom_point()
grid.arrange(p1, p2, ncol=2)

## Line plots using ggplot2

data(economics)
head(economics)

ggplot(economics, aes(x=date,y=pop)) + geom_line()

## Preparing data for multiple line charts


require(lubridate)
## Create month and year columns
economics$year <- year(economics$date)
economics$month <- month(economics$date)
## Subset the data
econ2000 <- economics[which(economics$year>=2000),]
head(econ2000)

g <- ggplot(econ2000,aes(x=month,y=pop))
g <- g + geom_line(aes(color=factor(year), group=year))
g <- g + scale_color_discrete(name="Year")
g <- g + labs(title="Population Growth", x="Month",y="Population")
g

## Theme in ggplot2
#install.packages("ggthemes")
require(ggthemes)
g2 <- ggplot(diamonds, aes(x=carat,y=price)) + geom_point(aes(color=color))

## Lets apply few themes
p1 <- g2 + theme_economist() + scale_color_economist()
p2 <- g2 + theme_excel() + scale_color_excel()
p3 <- g2 + theme_tufte()
p4 <- g2 + theme_wsj()
grid.arrange(p1, p2, p3, p4, nrow=2, ncol=2)

theMatrix <- matrix(1:9, nrow=3)
theMatrix

apply(theMatrix,1,sum) ## Row Sum

apply(theMatrix,2,sum) ## Column Sum

theMatrix[2,1] <- NA
theMatrix

apply(theMatrix,1,sum)

apply(theMatrix,1,sum,na.rm=TRUE)

theList <- list(A=matrix(1:9,3), B=1:5,C=matrix(1:4,2), D=2)
theList

lapply(theList,sum)

sapply(theList,sum)

## Counting no of characters in each word
theNames <- c("Jared","Deb","Paul")
theNames

sapply(theNames,nchar)

## build two lists
firstList <- list(A=matrix(1:16,4),B=matrix(1:16,2),c(1:5))
secondList <- list(A=matrix(1:16,4),B=matrix(1:16,8),c(15:1))
firstList
secondList

## test element by element if they are identical
mapply(identical,firstList,secondList)

simpleFunc <- function(x,y) {
              NROW(x) + NROW(y)
              }
mapply(simpleFunc,firstList,secondList)

require(ggplot2)
data(diamonds)
head(diamonds)

aggregate(price~cut, diamonds,mean)

aggregate(price~cut, diamonds,mean,na.rm=TRUE)

aggregate(price~cut + color, diamonds,mean)

aggregate(cbind(price,carat)~ cut + color,diamonds,mean)

#Creating data.table is just like creating data.frames , and the two are very similar.
require(data.table)
## Create a regular data.frame
theDf <- data.frame(A=1:10,B=letters[1:10],C=LETTERS[1:10],D=rep(c("One","Two","Three"),length.out=10))
## Create a data.table
theDt = data.table(A=1:10,B=letters[1:10],C=LETTERS[1:10],D=rep(c("One","Two","Three"),length.out=10))
## Print and compare
theDt

class(theDf$B) # By default, characters in data.frames are factors.
class(theDt$B) # By default, characters in data.tables are character strings.

#And a data.frame can be created from a data.table
require(ggplot2)
diamondsDT <- data.table(diamonds)
diamondsDT

theDt[1:2,]

theDt[theDt$A >=7,]

theDt[,list(A,C)]

theDt[,c("A","C"),with=FALSE]

## show tables
tables()

## set the key
setkey(theDt, D)
## show the data.table again
theDt

key(theDt)

theDt[c("One","Two"),]

setkey(diamondsDT,cut,color)

diamondsDT[J("Ideal"),c("E","D")]

aggregate(price~cut,diamonds,mean)

diamondsDT[,mean(price),by=cut]

diamondsDT[,list(price=mean(price)),by=cut]
## Aggregate on  multiple columns
diamondsDT[,list(price=mean(price)),by=list(cut,color)]

diamondsDT[,list(price=mean(price), carat=mean(carat), caratSum=sum(carat)),by=list(cut,color)]

x <- sample(1:100, size = 100, replace = TRUE)
x

mean(x)

# copy x
y <- x
# randomly setting 20 values to NA
y[sample(1:100, size=100, replace=TRUE)] <- NA
y

mean(y)
mean(y, na.rm=TRUE)

grades <-  c(95,72,87,66)
weights <- c(1/2,1/4,1/8,1/8)
weighted.mean(x=grades, w=weights)

var(x)

sd(y, na.rm=TRUE)

min(x)
max(x)
median(x)

summary(x)
The cumulative density function gives you the probability of a random variable being on or below a certain value.

The quantile function is the opposite of that. i.e. you give it a probability and it tells you the random variable value.

So the median is the value of the quantile at the probability value of 0.5.

A quartile is the value of the quantile at the probabilities 0.25, 0.5 and 0.75.

So, in general, you can use the quantile. The quartile is a special case.
The summary also displayed the first and third quantiles. To calculate other quantile values we can use quantile function.

quantile(x,probs= c(0.1, 0.25, 0.5, 0.75, 0.99))

Quantiles are numbers in a set where a certain percentage of the numbers are smaller than that quantile. For instance, of the numbers through 1 to 200, 75th quantile- the number that is larger than 75% of the numbers is 150.25.

require(ggplot2)
head(economics)

cor(economics$pce, economics$psavert)

cor(economics[,c(2,4:6)])

install.packages("GGally")
library(GGally)
GGally::ggpairs(economics[,c(2,4:6)])

require(reshape2)
require(scales)
econCor <- cor(economics[,c(2,4:6)])
## Converting to long format
econMelt <- melt(econCor,varnames=c("x","y"),value.names="Correlation")
econMelt

#Now we use this data and create our heatmap for the correlation values using ggplot2.
ggplot(econMelt,aes(x=x,y=y)) + 
    geom_tile(aes(fill=correlation)) +
    scale.fill.gradient2(
        low=muted("red"),
        mid="white",                      
        high="steelblue"),
        guide=guide.colorbar(ticks=FALSE,barheight=10),
        limits=c(-1,1)) + 
    theme.minimal() + 
    labs(x=NULL,y=NULL)

Now we use this data and create our heatmap for the correlation values using ggplot2.
ggplot(econMelt,aes(x=x,y=y)) + 
    geom_tile(aes(fill=correlation)) +
    scale.fill.gradient2(
        low=muted("red"),
        mid="white",                      
        high="steelblue"),
        guide=guide.colorbar(ticks=FALSE,barheight=10),
        limits=c(-1,1)) + 
    theme.minimal() + 
    labs(x=NULL,y=NULL)



# ## Loading tips data from ggplot2


data(tips,package="reshape2")
head(tips)
#dim(tips)


## One sample t-test


t.test(tips$tip,	alternative="two.sided",	mu=2.50)

##	build	a	t	distribution
randT	<- rt(30000,	df=NROW(tips)-1)

#	get	t-statistic	and	other	information
tipTTest	<- t.test(tips$tip,	alternative="two.sided",	mu=2.50)

## Plot it
library(ggplot2)
ggplot(data.frame(x=randT))	+
					geom_density(aes(x=x),	fill="grey",	color="grey")	+
					geom_vline(xintercept=tipTTest$statistic)	+
					geom_vline(xintercept=mean(randT)	+	c(-2,	2)*sd(randT),	linetype=2)

## One sided t-test


t.test(tips$tip,	alternative="greater",	mu=2.50)

## Shapiro test for normality


shapiro.test(tips$tip)

shapiro.test(tips$tip[tips$sex	==	"Female"])

shapiro.test(tips$tip[tips$sex	==	"Male"])


## Visual test of normality

#	all	the	tests	fail	so	inspect	visually
ggplot(tips,	aes(x=tip,	fill=sex))	+ geom_histogram(binwidth=.5,	alpha=1/2)


## Ansari-Bradley test for variances


ansari.test(tip	~	sex,	tips)



## Two sample t-test


t.test(tip	~	sex,	data=tips,	var.equal=TRUE)



## Reshaping tips data


library(plyr)
tipSummary	<- ddply(tips,	"sex",	summarize,
										tip.mean=mean(tip),	tip.sd=sd(tip),
										Lower=tip.mean	-	2*tip.sd/sqrt(NROW(tip)),
										Upper=tip.mean	+	2*tip.sd/sqrt(NROW(tip)))
tipSummary

## Visualising confidence intervals

ggplot(tipSummary, aes(x=tip.mean, y=sex)) + geom_point() + geom_errorbarh(aes(xmin=Lower, xmax=Upper), height=.2)


## Two- paired t-test
install.packages("UsingR")
library(UsingR)

data(father.son,	package='UsingR')
head(father.son)


t.test(father.son$fheight,	father.son$sheight,	paired=TRUE)

## Visually testing paired two sample t-test


heightDiff	<-	father.son$fheight	-	father.son$sheight
ggplot(father.son,	aes(x=fheight	-	sheight))	+
				geom_density()	+
				geom_vline(xintercept=mean(heightDiff))	+
				geom_vline(xintercept=mean(heightDiff)	+ 2*c(-1,	1)*sd(heightDiff)/sqrt(nrow(father.son)),linetype=2)


## ANOVA


tipAnova	<- aov(tip	~	day	-	1,	tips)
summary(tipAnova)



## Visual Inspection of ANOVA

tipsByDay	<- ddply(tips,	"day",	plyr::summarize,
																				tip.mean=mean(tip),	tip.sd=sd(tip),
																				Length=NROW(tip),
																				tfrac=qt(p=.90,	df=Length-1),
																				Lower=tip.mean	-	tfrac*tip.sd/sqrt(Length),
																				Upper=tip.mean	+	tfrac*tip.sd/sqrt(Length)
																				)

ggplot(tipsByDay,	aes(x=tip.mean,	y=day))	+	geom_point()	+
					geom_errorbarh(aes(xmin=Lower,	xmax=Upper),	height=.3)



