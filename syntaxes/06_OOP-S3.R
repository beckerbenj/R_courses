# Advanced R
# Spring Academy FDZ, March 2021

# R Object Oriented Programming - S3
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Input
#===========================================================
#...........................

# create an S3 class
#...........................
# dirty way:
my_object <- list(a = 1, b = 2)
class(my_object) <- "my_class"
str(my_object)

# using a constructor funciton 
my_class <- function(a, b = 0L) {
  if(!is.integer(b)) stop("'b' should be an integer.")
  if(length(a) != length(b)) stop("'a' and 'b' should have the same length.")
  structure(list(a = a, b = b),
            class = "my_class")
}
my_object <- my_class(a = 1, b = 2L)
str(my_object)


# create an method for an existing generic
#.........................................
summary.my_class <- function(object, new_argument = "default", ...){
  cat("new_argument = ", new_argument, "\n")
  data.frame(a = object$a, b = object$b)
}

summary(my_object)


# no restrictions on not-working code
#.........................................
my_object <- list(a = 1:5, b = seq(2, 0))
summary(my_object)
class(my_object) <- "my_class"
summary(my_object) 

# compare to
my_object <- my_class(a = 1:5, b = seq(2, 0))


# create a new generic 
#......................
new_generic <- function(object, ...)
  UseMethod("new_generic")

new_generic.data.frame <- function(object, ...){
  cat("This code does nothing. \n")
  object
}

new_generic.my_class <- function(object, new_argument, ...){
  cat("This code simply returns a data.frame. \n")
  summary(object, ...)
}

new_generic.default <- function(object, new_argument, ...){
  cat("This code returns the object invisibly. \n")
  invisible(object)
}


new_generic(head(iris))
my_object <- my_class(a = c("some", "words"), b = c(5L, 1L))
new_generic(my_object)
new_generic(5)


# List methods
#...........................
# for a generic
print_methods <- methods(generic = "print")
length(print_methods)
head(print_methods)

# for a class
methods_for_glm <- methods(class = "glm")
length(methods_for_glm)
head(methods_for_glm)



# Inspect the source code
#...........................
methods(generic = "summary")

# visible functions (in loaded packages)
summary.aov

# invisible functions (in unloaded packages) - indicated with an asterix
summary.aovlist
getS3method("summary", "aovlist")


# further information
#...........................
?methods
?S3Methods



# Exercises
#===========================================================
# Consider the following two S3 constructor functions. The first constructor function can be used to generate an object of class "album", the second constructor function creates an object of class "deck".

# constructor function for class "album"
album <- function(album_name, band, year, 
                  track_list, 
                  genre = c("undefined", "pop", "rock", "classical", "jazz", "emo", "metal", "blues", "hip-hop", "folk", "world"), rating= 0){
  
  # album_name and band should be a single character
  album_name <- as.character(album_name)
  if(length(album_name) != 1) stop("'album_name' should be an single character string.")
  band <- as.character(band)
  if(length(band) != 1) stop("'band' should be an single character string.")
  
  # year should be a single integer
  year <- as.integer(year)
  if(length(year) != 1) stop("'year' should be an single integer.")
  
  # track_list should be a data.frame with columns
  #  - track_number
  #  - song_title
  #  - duration
  #  - n_plays
  if(!inherits(track_list, "data.frame")) stop("'track_list' should be of class 'data.frame'.")
  tl_names <- ! all()
  if(!all(names(track_list) %in% c("track_number", "song_title", "duration", "n_plays"))) stop("'track_list' should have the following columns: 'track_number', 'song_title', 'duration', and 'n_plays''.")
  
  # genre should be one of the options
  genre <- match.arg(genre)
  
  # rating should be a single numeric between 0 and 10
  if(!is.numeric(rating) || length(rating) != 1) stop("'rating' should be an single numeric.")
  if(rating < 0 || rating > 10) stop("'rating' should be a value between 0 and 10.")
  
  out <- structure(list(album_name = album_name, 
                        band = band,
                        year = year, 
                        track_list = track_list, 
                        rating = rating, 
                        genre = genre), 
                   class = "album")
  return(out)
}


# constructor function for class "deck"
deck <- function(...){
  albums <- list(...)
  # all objects should be albums
  if(!all(sapply(albums, function(album) inherits(album, what = "album")))) stop("A 'deck' can only containg objects of class 'album'.")
  structure(albums, 
            class = "deck")
}


# In addition, the following code creates a couple of albums and collects them in a deck.

# album Rubber Soul (Beatles)
rubber_soul <- album(
  album_name = "Rubber Soul", 
  band = "The Beatles", 
  year = 1965,
  track_list = data.frame(
    track_number = 1:14, 
    song_title = c("Drive My Car", "Norwegian Wood (This Bird Has Flown)", 
                   "You Won't See Me", "Nowhere Man", "Think for Yourself", 
                   "The Word", "Michelle", "What Goes On", "Girl",
                   "I'm Looking Through You", "In My Life", "Wait", 
                   "If I Needed Someone", "Run for Your Life"),
    duration = c(145, 121, 198, 160, 136, 161, 160, 167, 150, 143, 144, 
                 132, 140, 138),
    n_plays = rep(0, 14)),
  genre = "pop", 
  rating = 6.6)


# Album Nevermind (Nirvana)
nevermind <- album(
  album_name = "Nevermind", 
  band = "Nirvana", 
  year = 1991,
  track_list = data.frame(
    track_number = 1:12, 
    song_title = c("Smells Like Teen Spirit", "In Bloom", "Come as You Are", 
                   "Breed", "Lithium", "Polly", "Territorial Pissings", 
                   "Drain You", "Lounge Act", "Stay Away", "On a Plain", 
                   "Something in the Way"),
    duration = c(301, 254, 219, 183, 257, 142, 177, 223, 146, 212, 196, 232),
    n_plays = rep(0, 12)),
  genre = "rock")


# Albun Croocked Rain, Croocked Rain (Pavement)
croocked_rain <- album(
  album_name = "Croocked Rain, Croocked Rain", 
  band = "Pavement", 
  year = 1994,
  track_list = data.frame(
    track_number = 1:12, 
    song_title = c("Silence Kid", "Elevate Me Later", "Stop Breathin", 
                   "Cut Your Hair", "Newark Wilder", "Unfair", "Gold Soundz", 
                   "5-4=Unity", "Range Life", "Heaven Is a Truck", 
                   "Hit the Plane Down", "Fillmore Jive"),
    duration = c(181, 171, 268, 187, 233, 153, 161, 129, 294, 150, 216, 398),
    n_plays = rep(0, 12)),
  genre = "rock")


# Create a deck with the three albums 
my_deck <- deck(nevermind, rubber_soul, croocked_rain)


# 1. write a print method for the "album"-class. Make sure you include an argument that specifies the number of tracks to be printed. The output should look something like:
#   > rubber_soul
#   Rubber Soul 
#   by The Beatles (1965) 
#   Current rating: 0 / 10 
#   
#   Displaying first 3 of 14 tracks: 
#     track_number                           song_title
#   1            1                         Drive My Car
#   2            2 Norwegian Wood (This Bird Has Flown)
#   3            3                     You Won't See Me
#     duration n_plays
#   1      145       0
#   2      121       0
#   3      198       0

# solution
print.album <- function(x, n_tracks = 3, ...){
  cat(x$album_name, " \n", sep = "")
  cat("by ", x$band,  " (", x$year, ") \n", sep = "")
  cat("Current rating: ", round(x$rating, 1), " / 10 \n", sep = "")
  
  if(n_tracks > 0){
    cat("\n", "Displaying first ", n_tracks, 
        " of ", dim(x$track_list)[1], " tracks: \n", sep = "")
    print(x$track_list[seq_len(n_tracks), ])
  }
}

# 2. write a print method for the "deck"-class. In addition to some information about the deck, the album with the highest rating should also be printed. The output should look something like:

#  >my_deck
#  A deck with 3 albums. 
#  Average rating: 2.2 / 10. 
#  
#  The album with the highest rating is ... 
#  Rubber Soul 
#  by The Beatles (1965) 
#  Current rating: 6.6 / 10 

# solution
print.deck <- function(x, get_top_rated = TRUE, ...){
  cat("A deck with ", length(x), " albums. \n", sep = "")
  ratings <- sapply(x, function(album) album$rating)
  cat("Average rating: ", round(mean(ratings), 1), " / 10. \n \n", sep = "")
  
  cat("The album with the highest rating is ... \n", sep = "")
  print(x[[which.max(ratings)]], n_tracks = 0)
}

# 3. Write a generic to change the rating of an album. Add a method for the "album" class. There should be a "new_rating"-argument with the new rating. The return object should be of the same class of the input-object.
# the following could should give similar output:
# > rubber_soul <- change_rating(rubber_soul, new_rating = 7.13)
# > print(rubber_soul, n_tracks = 0)
# Rubber Soul 
# by The Beatles (1965) 
# Current rating: 7.1 / 10 


# solution
## generic
change_rating <- function(x, new_rating, ...)
  UseMethod("change_rating")


## method for "album"-class
change_rating.album <- function(x, new_rating, ...){
  album(
    album_name = x$album_name, 
    band = x$band, 
    year = x$year,
    track_list = x$track_list,
    genre = x$genre, 
    rating = new_rating)
}



# 4. Add a method for the "deck" class. The return object should be of the same class of the input-object.
# the following could should give similar output:
# > change_rating(my_deck, album_name = "Croocked Rain, Croocked Rain", 
#                 +               new_rating = 7.52)
# A deck with 3 albums. 
# Average rating: 4.7 / 10. 
# 
# The album with the highest rating is ... 
# Croocked Rain, Croocked Rain 
# by Pavement (1994) 
# Current rating: 7.5 / 10 


## method for "deck"-class
change_rating.deck <- function(x, album_name, 
                               band = NULL, year = NULL, 
                               new_rating, ...){
  this_album <- which(sapply(x, function(album) album$album_name == album_name))
  if(!is.null(band)) {
    this_album <-  this_album[sapply(x[this_album], function(album) album$band == band)]
  }
  if(!is.null(year)) {
    this_album <-  this_album[sapply(x[this_album], function(album) album$year == year)]
  }
  
  if(length(this_album) == 0) stop("No album found with these specifications.")
  if(length(this_album) > 1) stop("Multiple albums correspond to the spefications. Consider adding 'band' and/or 'year' information.")
  
  x[[this_album]] <- change_rating(x[[this_album]], new_rating = new_rating)
  return(x)
}

