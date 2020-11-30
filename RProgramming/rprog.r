c(1, 2, 3)
c("0", 1, 2, 3) #coercion
list("0", TRUE, c(1, 2, 3))
#matrix constr column wise
m <- matrix(1:6, nrow=2, ncol=3)
attributes(m)
m <- 1:10
m
dim(m) <- c(2, 5)
m
x <- 1:5
y <- seq(10, 50, 10)
help(":")
cbind(x, y)
rbind(x, y)
#factor. unordered/ordered label. categorical data
z <- factor(c("yes", "no", "yes"))
unclass(z)
#levels alphabetical if not specified
z <- factor(c("yes", "no", "yes"), levels=c("yes", "no"))
unclass(z)

# []: returns object of same class. exception: matrix returns vector
# [[]]: use w/ list/dframe. 
# complete.cases(): subset w/o missing values

#lexical scoping
a <- 10
y <- function(x){
  a <- 2
  a^2 + g(x)
}
g <- function(x){
  a*x
}
y(2)

# lapply/sapply: operate a function on vector elements
# mapply: vectorize a function which takes primitive arguments
# tapply: apply function over subsets of a vector
# split: GROUPBY
# set seed to reproduce the same random numbers later if need arises
# xlsx2 fast
# which: gives indices when condition true. use when col has NA values

