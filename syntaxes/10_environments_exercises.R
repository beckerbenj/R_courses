# Advanced Programming in R
# Zurich R Courses, October 2021


# Environments and scoping
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

## Useful functions -----
## __________________________________________________________________________

?environment  
environment()   # returns the current evaluation environment
?ls             # returns the objects in the current environment
parent.env()    # returns the enclosing environment
new.env()       # creates a new environment (with as the current environment 
                # as the enclosing environment)
globalenv()     # returns the global environment
empty.dump()    # returns the empty environment

?rlang::env()   # creates a new environment (with as the current environment 
# as the enclosing environment)



## Creating an environment
env1 <- new.env()
env1$a <- 15
env1$fast_mean <- function(x) sum(x)/length(x)
env1$myself <- env1
env1
ls(env1)
names(env1)


env2 <- rlang::env(a = 15, 
                   fast_mean = function(x)sum(x)/length(x),
                   env1 = env1)
rlang::env_print(env2)
rlang::env_names(env2)


# enclosing environments
parent.env(env1)
parent.env(env1$myself)
parent.env(env1$myself$myself)
parent.env(env1) <- env2
parent.env(env1)


env3 <- rlang::new_environment(
  list(b = "b", 
       get_current_env = function() environment()), 
  parent = env2)
rlang::env_parent(env3)


# lexical scoping: search through environments
# ctrl + shift + F10
env1 <- new.env()
env2 <- new.env(parent = env1)
env3 <- new.env(parent = env2)

env1$a <- "a"
env2$b <- "b"
env3$c <- "c"

lapply(c(env1, env2, env3), ls)

# get looks in the environment, when inherits = TRUE, the search continues
#   in the enclosing environment (and so on)
lapply(c(env1, env2, env3), 
       function(env) try(get(x = "a", envir = env)))
lapply(c(env1, env2, env3), 
       function(env) try(get(x = "b", envir = env)))
lapply(c(env1, env2, env3), 
       function(env) try(get(x = "a", envir = env, inherits = FALSE)))

# assign assigns a name/reverence to an object in a specific environment.
#   when inherits = TRUE, assign tries to replace the object looking in 
#   the chain of enclosing enironments. If the name is not 
#   found, the assignment is done in the global environment

ls(env1)
ls(env3)
assign("d", "new object", envir = env3)
assign("a", "replaced", envir = env3, inherits = TRUE)
ls(env3)
get("a", env1)

# <<- is similar to assign(inherits = TRUE)

# reference semantics
# ctrl + shift + F10

# lists can be copied on modification
list1 <- list(a = "a", b = "5", c = mean)
list2 <- list1
list2$b <- 10
list1$b
list1$a <- NULL
names(list1)

# environments are NOT copied on modification
env1 <- rlang::env(a = "a", b = "5", c = mean)
env2 <- env1
env2$b <- 10
env1$b
env1$a <- NULL
names(env1)

# environments are unordered
env1[[3]]
env1[["c"]]
env1[c("a", "c")]  # fails! 


# search path
search()
rlang::search_envs()




# where does R find stuff

a <- b <- c <- d <- e <- 5
create_fun <- function(){
  a <- b <- c <- d <- 5
  return(function(a = 3, b = 3, c = 3){
    a <- 1
    c(a = a, b = b, c = c, d = d, e = e)
  })
}
fun <- create_fun()
fun(a = 2, b = 2)



## Exercises ----
## __________________________________________________________________________


# 1. Check which objects are in the following environments, and check their
#    enclosing environment
#    - the global environment
#    - the stats-package environment
#    - the stats-namespace environment
#    - the imports environment of the stats package
#    - the empty environment

# global environment
ls()
ls(globalenv())
parent.env(globalenv())


# package:stats environment 
pkg_stats <- as.environment("package:stats")
ls(pkg_stats)
length(pkg_stats)
parent.env(pkg_stats)


# namespace:stats environment
nmsp_stats <- asNamespace("stats")
ls(nmsp_stats)
length(ls(nmsp_stats))
parent.env(nmsp_stats)


# imports:stats environment
imp_stats <- parent.env(nmsp_stats)
ls(imp_stats)
length(ls(imp_stats))
parent.env(imp_stats)


# empty environment
ls(emptyenv())
length(emptyenv())
parent.env(emptyenv())



# 2. Create a new environment called e1 which contains the following objects:
#    number <- 3
#    print_number <- function() cat(number, "\n")
#    - try the function, does it work? 
#    - check what the enclosing environment of the function is. 
#    - change the enclosing environment of the function to the e1 environment
#    - does the function work?
#    - copy the print_number function to the global environment: print_number_global
#    - does print_number_global work?
#    - check what the enclosing environment of the print_number_global is. 

e1 <- new.env()
e1$print_number <- function() cat(number, "\n")
e1$number <- 3

e1$print_number()
environment(e1$print_number)
environment(e1$print_number) <- e1
e1$print_number()

print_number_global <- e1$print_number
print_number_global()
environment(print_number_global)





# 3. write a function that creates a environment. Use two arguments: 
#    - ... = named objects
#    - enclosing_env = an environment or "self"
# TIP: make use of list2env, and list(...)
#
#    Use the function you wrote to repeat exercise 2.

new_env <- function(..., enclosing_env = parent.frame()){
  objects <- list(...)
  names_objects <- names(objects)
  if(any(is.na(names_objects))) stop("All objects in '...' should be named.")
  if(anyDuplicated((names_objects))) stop("All names in '...' should be unique")
  list2env(objects, parent = enclosing_env)
}

e1 <- new_env(number = 3, print_number = function() cat(number, "\n"))
environment(e1$print_number) <- e1



# 4. write a set_enclosing_env function that can set the enclosing environment
#    both for a function and for an environment

set_enclosing_env <- function(object, enclosing_env){
  `fun<-` <- switch(typeof(object), 
                "closure" = `environment<-`,
                "environment" = `parent.env<-`, 
                stop("'object' should be a closure or an environment."))
  fun(object) <- enclosing_env
  return(invisible(object))
}

print_number2 <- set_enclosing_env(e1$print_number, globalenv())
print_number2()
number <- 5

parent.env(e1)
set_enclosing_env(e1, e1)
rlang::env_print(e1)





# 5. write a recursive function that returns a list with the enclosing environments of
#    an environment
# Tips: 
#    - make use of the fact that environments are modified in place


get_enclosing_envs <- function(env = environment(), where = new.env()){
  if(is.null(where$n)) where$n <- 0
  where$n <- where$n + 1
  enclosing_env <- parent.env(env)
  assign(as.character(where$n), enclosing_env, envir = where)
  if(identical(enclosing_env, emptyenv())) {
    cat("Empty environment reached. \n")
    rm(n, envir = where)
    out <- as.list(where)
    return(out[order(as.numeric(names(out)))])
  } else get_enclosing_envs(enclosing_env, where)
}


get_enclosing_envs()




# 6. Modify the function you wrote in exercise 4, so that it also lists the
#    the enclosing environments of a function
#    try out the function

get_enclosing_envs <- function(object = environment(), where = new.env()){
  if(is.null(where$n)) where$n <- 0
  where$n <- where$n + 1
  enclosing_env <- switch(typeof(object), 
                          "environment" = parent.env(object),
                          "closure" = environment(object), 
                          stop("The object should be of type 'environmment' or 'closure'.")
  )
  assign(as.character(where$n), enclosing_env, envir = where)
  if(identical(enclosing_env, emptyenv())) {
    cat("Empty environment reached. \n")
    rm(n, envir = where)
    out <- as.list(where)
    return(out[order(as.numeric(names(out)))])
  } else get_enclosing_envs(enclosing_env, where)
}

get_enclosing_envs(lm)



# 7. Write a recursive function that returns the binding environment of 
#    a function
#    TIP: use ?exists
#    
#    use the function to find the binding environment of the var() function.
#    debug the sd() function, and while debugging find the binding environment
#    of the var() function.

get_binding_env <- function(name, env = parent.frame()){
  if(exists(name, envir = env, inherits = FALSE)) return(env)
  if(identical(env, emptyenv())) stop("'", name, "' not found.", call. = FALSE)
  env <- parent.env(env)
  get_binding_env(name, env)
}

get_binding_env("var")
#  <environment: package:stats>
#    attr(,"name")
#  [1] "package:stats"
#  attr(,"path")
#  [1] "C:/R/R-4.1.1/library/stats"

debugonce(sd)
sd(1:5)
get_binding_env("var")
#  <environment: namespace:stats>