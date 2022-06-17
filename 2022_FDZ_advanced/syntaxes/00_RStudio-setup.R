#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# RStudio Setup
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




## Create a new RStudio Project


# 1. Save the course content to a directory on your machine


# 2. Open RStudio


# 3. In RStudio, create a new R Studio Project: Choose File < New Project < ...


# 4. Choose "Existing Directory"


# 5. Browse to the directory on your machine where you copied the course 
#    content and select the ``R-programming'' folder as the 
#    Project working directory


# 6. Click "Open in new session"


# 7. Click "Create Project"





## After creating the RStudio Project...
## - Check your current working directory:
getwd()

## - Check the directories/folders in your working directory
list.dirs()


## Create a folder named "R" for your R scripts and a folder named "data" 
#  for data.
## Again check the directories/folders in your working directory
list.dirs()


## After creating the folders, save this script in the "R"-folder
## Check which files are in your R-folder:
list.files(".\\R")


## Try out some keyboard shortcuts
### Tools < Keyboard Shortcuts Help



## Set your preferences via the global options
# 1. Tools < Global Options
# 2. Under General
#    - DON'T "Restore .RData into workspace at startup"
#    - NEVER "Save workspace to .Rdata on exit:"
#    - Save the code instead
#    - use saveRDS() and readRDS() for objects that require a long 
#      time to compute
# 3. Further personalize RStudio     


