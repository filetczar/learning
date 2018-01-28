######################
# Phil Azar 
# Learning R 
# Topic: Purrr Package
# Using Ch. 21 of R4DS
######################

library(tidyverse)
setwd('/Users/acazar/Desktop/learning/R/')

#############################################
# 1. Compute the mean for every col in mtcars
# 2. Determine type in each col of flights 
# 3. number of unique values in col of Iris
# 4. Generate 10 normals, for u -10,0,10,100
############################################

# 1. 

head(mtcars)
means <- list()
for(i in 1:ncol(mtcars)) { 
  means[[i]] <- mean(mtcars[,i])
  }

# 2. 
flights <- nycflights13::flights
col_types <- vector()
for(i in seq_along(flights)) { 
  col_types[[i]] = class(flights[[i]])[1]
}

# 3.
col_length <- vector(length = ncol(iris))
for(i in seq_along(iris)) {
  col_length[[i]] <- length(unique(iris[[i]]))
  
}

# 4. 

norm_ls <- list()
means <- c(-10,0,10,100)
for(i in 1:length(means)){ 
  norm_ls[[i]] = rnorm(10, mean = means[i])
  }
norm_ls[[2]]


# Eliminate the following for loops
# 1
out <- ""
for (x in letters) {
  out <- stringr::str_c(out, x)
}

# re written as: 

out <- paste0(letters, collapse="")

# 2
set.seed(123)
x <- sample(100)
sd <- 0
for (i in seq_along(x)) {
  sd <- sd + (x[i] - mean(x)) ^ 2
}
sd <- sqrt(sd / (length(x) - 1))

# re written as 

sd <- sd(sample(100))

x <- runif(100)
out <- vector("numeric", length(x))
out[1] <- x[1]
for (i in 2:length(x)) {
  out[i] <- out[i - 1] + x[i]
}

# re written as:
out_new <- cumsum(x)

# Write the lyrics of alice the camel using a for loop
for(i in rev(1:6)){ 
  print(paste0("Alice the camel has ", i -1, " humps"))
}

# write a function for 10 in the bed
# take number and place as inputs

song <- function(number = 10, place = 'bed') { 
  for(i in rev(1:number)) { 
    print(
      paste0(
      "There were ", i ," in the ", place
            )
          )
    }
}

# convert 99 bottles of beer on the wall to a function

song_2 <- function(vessel = 'bottles', number = 99, liquid = 'beer', location = 'wall'){ 
  
  for(i in rev(1:number)) { 
    if(i > 1 ){
      vessel_qa = vessel
    } else {vessel_qa = substr(vessel, 1, stringr::str_length(vessel) -1)}
    print(
      paste0(
        "There were ", i," ", vessel_qa, " of ", liquid , " on the ", location
      )
    )
    }
  
  
  }

# prelocating output: how does it effect performance 
test_lengths <- function(size = c(10,100,1000,10000,100000), out_length = FALSE) {
ol= 0
for(i in seq_along(size)) {
  x <- 1:size[i]

begin <- Sys.time()
if(out_length){
  ol = size[i]} else {ol = 0}

output <- vector("integer", ol)
for (i in seq_along(x)) {
  output <- c(output, lengths(x[[i]]))
}
end <- Sys.time()
diff_t <- difftime(end, begin, units='secs')
print(
  paste0('When out length equals ', 
         ol, ' and x is size ', 
         max(x), ' it takes ', diff_t, " secs")
)
}
}

test_lengths(out_length = TRUE)

# Read in multiple csv files 
# load into a single df
files <- dir("data/", pattern = "\\.csv$", full.names = TRUE)
files_ls <- list()
for(i in seq_along(files)) { 
  files_ls[[i]] <- read_csv(files[[i]])
}
files_df <- bind_rows(files_ls)

# write a function that prints out column name and mean

show_mean <- function(data= iris) { 
  for(i in seq_along(data)) {
    if(class(data[[i]]) == 'numeric') {
    print(
      paste0(names(data[i]),": ", round(mean(data[[i]]),2))
    )
    }
  }
  }
 

models <- mtcars %>% 
  split(.$cyl) %>% 
  purrr::map(~lm(mpg ~wt, data = .))
models %>% 
  map(summary) %>% 
  map_dbl(~.$r.squared)


# 21.5.3 Exercises
map_dbl(mtcars,mean)
map(flights, class) 
iris %>% 
  map(., unique) %>% 
  map(., length) %>% 
  flatten_df()

map(means,rnorm, n = 10)

map_lgl(iris, is.factor)
map(1:5,  runif)
map(-2:2, rnorm, n = 5)
map_dbl(-2:2, rnorm, n =5)

x = list('a', 1, 50)

every(x, is_character)
