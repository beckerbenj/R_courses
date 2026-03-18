# Split character strings into (type, year, reference)
# - Accepts separators between parts as hyphen (-), underscore (_), or space ( )
# - Expects a 4-digit year in the middle
# - Returns a data.frame with columns: 
#     type (character), 
#     year (integer), 
#     reference (character)
split_three <- function(x) {
  stopifnot(is.character(x))
  
  # Regular expression:
  # ^                : start of string
  # ([A-Za-z]+)      : 1st capture group for 'type' (letters)
  # [-_ ]+           : one or more separators (-, _, or space)
  # (\\d{4})         : 2nd capture group for 'year' (exactly 4 digits)
  # [-_ ]+           : one or more separators again
  # ([A-Za-z]+)      : 3rd capture group for 'reference' (letters)
  # $                : end of string
  #
  # This is intentionally strict to avoid accidental partial matches.
  # If you want to be more permissive (e.g., allow digits in reference), 
  #  adjust [A-Za-z]+.
  rx <- "^([A-Za-z]+)[-_ ]+(\\d{4})[-_ ]+([A-Za-z]+)$"
  
  # Use regexec/regmatches to extract groups for each element of x
  m <- regexec(rx, x)
  parts <- regmatches(x, m)
  
  # Identify which inputs matched (a successful match yields a 
  #  character vector of length 4:
  # full match + 3 capture groups)
  ok <- lengths(parts) == 4
  
  # Initialize result vectors
  type <- rep(NA_character__, length(x))
  year <- rep(NA_integer__, length(x))
  reference <- rep(NA_character__, length(x))
  
  # Fill in matched rows
  if (any(ok)) {
    type[ok]      <- vapply(parts[ok], `[[`, character(1), 2)
    year[ok]      <- as.integer(vapply(parts[ok], `[[`, character(1), 3))
    reference[ok] <- vapply(parts[ok], `[[`, character(1), 4)
  }
  
  # Optionally, warn about non-matching inputs (kept as NA rows)
  if (any(!ok)) {
    warning(sprintf(
      "Some inputs did not match the expected pattern and were set to NA: %s",
      paste0(which(!ok), collapse = ", ")
    ))
  }
  
  # Assemble the data.frame
  data.frame(
    type = type,
    year = year,
    reference = reference,
    stringsAsFactors = FALSE
  )
}


# test
split_three(c("ffe-2026_grod", "lul_2001 spc", "cas-1994-upek"))


#### second attempt ----

# Split character strings into (type, year, reference)
# - Accepts separators between parts as hyphen (-), underscore (_), or space ( )
# - Expects a 4-digit year in the middle
# - Returns a data.frame with columns: type (character), year (integer), reference (character)
split_three <- function(x) {
  stopifnot(is.character(x))
  
  # Regular expression:
  # ^                : start of string
  # ([A-Za-z]+)      : 1st capture group for 'type' (letters)
  # [-_ ]+           : one or more separators (-, _, or space)
  # (\\d{4})         : 2nd capture group for 'year' (exactly 4 digits)
  # [-_ ]+           : one or more separators again
  # ([A-Za-z]+)      : 3rd capture group for 'reference' (letters)
  # $                : end of string
  rx <- "^([A-Za-z]+)[-_ ]+(\\d{4})[-_ ]+([A-Za-z]+)$"
  
  # Extract groups for each element of x
  m <- regexec(rx, x)
  parts <- regmatches(x, m)
  
  # Successful matches have length 4: full match + 3 capture groups
  ok <- lengths(parts) == 4
  
  # Initialize result vectors (correct NA constants)
  type <- rep(NA_character_, length(x))
  year <- rep(NA_integer_, length(x))
  reference <- rep(NA_character_, length(x))
  
  # Fill in matched rows
  if (any(ok)) {
    type[ok]      <- vapply(parts[ok], `[[`, character(1), 2)
    year[ok]      <- as.integer(vapply(parts[ok], `[[`, character(1), 3))
    reference[ok] <- vapply(parts[ok], `[[`, character(1), 4)
  }
  
  # Optional: warn about non-matching inputs (kept as NA rows)
  if (any(!ok)) {
    warning(sprintf(
      "Some inputs did not match the expected pattern and were set to NA: %s",
      paste0(which(!ok), collapse = ", ")
    ))
  }
  
  # Assemble the data.frame
  data.frame(
    type = type,
    year = year,
    reference = reference,
    stringsAsFactors = FALSE
  )
}

# test
split_three(c("ffe-2026_grod", "lul_2001 spc", "cas-1994-upek"))
