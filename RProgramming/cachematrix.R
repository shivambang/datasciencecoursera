## Creates two functions to cache inverse of a matrix

## makeCaheMatrix takes in a matrix and converts it to an object that can store
## both the matrix and its inverse

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y){
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    setInverse <- function(i) inv <<- i
    getInverse <- function() inv
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}


## cacheSolve returns the inverse of the matrix created using makeCacheMatrix
## The inverse is calculated if not already cached 
## and is then cached for future use.

cacheSolve <- function(x, ...) {
    inv <- x$getInverse()
    if(!is.null(inv))
        return(inv)
    x$setInverse(solve(x$get()))
    x$getInverse()
}
