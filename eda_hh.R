prices <- read.csv("./Househunt/PHS_All_v1.csv")
names(prices)

par(mfrow=c(1,2))

#plot(prices$livingArea, prices$price, col=prices$bedrooms)
x <- prices$livingArea
y <- prices$price
prices$bedrooms <- as.factor(prices$bedrooms)
plot(x,y, col=prices$bedrooms)
#text(x+0.05,y+0.05, labels=as.character(prices$address.streetAddress))
legend("topleft", legend=levels(prices$bedrooms), 
       pch=1, col=levels(prices$bedrooms))
reg <- lm(prices$price~prices$livingArea)
reg
abline(reg)

x1 <- prices$bedrooms
y1 <- prices$price
plot(x1,y1)
#text(x1,y1, labels=as.character(prices$address.streetAddress))

# Kmeans cluster ALL HOMES
par(mfrow=c(1,1))
y <- y/1000
dataFrame <- data.frame(x,y)
sum(is.na(x)) #55 rows with a null area
df2 <- na.omit(dataFrame) #omit values with NA
dim(df2)
kmeansObj <- kmeans(df2,centers=3)
names(kmeansObj)
plot(x,y,col=kmeansObj$cluster,cex=1)
points(kmeansObj$centers,col=1:3,pch=3,cex=3,lwd=3)
kmeansObj
#text(x+0.05,y+0.05, labels=as.character(prices$address.streetAddress))

par(mfrow=c(1,2))
# Kmeans cluster ONLY FOR SALE
#for_sale <- read.csv("./Househunt/Only_For_sale.csv")
for_sale <- prices[prices$homeStatus =="FOR_SALE", ]
names(for_sale)

x2 <- for_sale$livingArea
y2 <- for_sale$price
y2 <- y2/1000
df3 <- data.frame(x2,y2)
dim(df3)
df3 <- na.omit(df3)
kmeansObj <- kmeans(df3,centers=4)
names(kmeansObj)
plot(x2,y2,col=kmeansObj$cluster,cex=1)
points(kmeansObj$centers,col=1:4,pch=3,cex=3,lwd=3)
kmeansObj

# Kmeans cluster ONLY FOR SALE Living Areas and No. of Bedrooms
z2 <- for_sale$bedrooms
z2 <- as.factor(z2)

df4 <- data.frame(x2,y2, z2)
dim(df4)
df5 <- na.omit(df4)
dim(df5)
kmeansObj <- kmeans(df5,centers=4)
names(kmeansObj)
plot(x2,y2,col=kmeansObj$cluster,cex=1)
points(kmeansObj$centers,col=1:4,pch=3,cex=3,lwd=3)
kmeansObj
