## Collatz conjecture

# https://en.wikipedia.org/wiki/Collatz_conjecture
# https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjIpPbm0qjzAhWBUcAKHcWFACYQwqsBegQIBhAB&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3D094y1Z2wpJg&usg=AOvVaw0XvkHLG0HxG43O7I2TgvGf

# 1. Use google (wikipedia) to learn about the Collatz Conjecture.


# 2. Write a function that prints the 3 * x + 1 path
#    - write simple pure functions and build the functiontionality using those 
#      funcitons.
#    - for instance, write a function to go up (3 * x + 1), and write a function
#      to go down.
#    - write a function that creates the path (using a loop)
#    - write a function that plots the path
#    - add arguments or pass arguments to include plotting options. Think about
#      good defaults

# 3. Write a function that finds the starting value that leads to the longest 
#    path


# 4. Write a function that finds the starting value that leads to the highest
#    intermediate value






















# write a function
up <- function(x) 3 * x + 1
down <- function(x) x / 2

do_collatz <- function(x){
  if((x %% 2) == 1) return(up(x))
  else return(down(x))
}

full_collatz <- function(x){
  start <- x
  count <- 0
  max_x <- max(x)
  while(x > 1){
    count <- count + 1
    x <- do_collatz(x)
    if(x > max_x) max_x <- max(x)
  }  
  
  return(c(x = start, max = max_x, steps = count))
}


out <- do.call(rbind, lapply(1:1000, full_collatz))

out[which.max(out[,3]),]

get_path <- function(x){
  start <- x
  path <- x
  count <- 0
  while(x > 1){
    count <- count + 1
    x <- do_collatz(x)
    path[count + 1] <- x
  }  
  
  return(list(x = start, max = max(path), steps = count, path = path))
}

plot_collatz <- function(x, type = "b", main = paste0("Starting Value = ", x), ...){
  path <- get_path(x)
  plot(path$path, type = type, main = main, ...)
}
