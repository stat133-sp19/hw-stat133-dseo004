#######################################################################
# title: Make-shots-data-script
# description: Download the data from Github, munipulate the data
#              and combine the separating data sets into a data set.
# input(s): 5 csv files
# output(s): 6 summary txt files, 1 shots data csv file
#######################################################################

# reading file with relative path
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)

# Add a column name to each imported data frame, that contains the name of the corresponding player:
iguodala$name <-  "Andre Iguodala"
green$name <-  "Draymond Green"
durant$name <- "Kevin Durant"
thompson$name <- "Klay Thompson"
curry$name <- "Stephen Curry"

###########################################################################
# Change the original values of shot_made_flag to more descriptive values: 
# replace "n" with "shot_no", and "y" with "shot_yes". 
###########################################################################
iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "shot_no"
iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "shot_yes"
green$shot_made_flag[green$shot_made_flag == "n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag == "y"] <- "shot_yes"
durant$shot_made_flag[durant$shot_made_flag == "n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "shot_yes"
curry$shot_made_flag[curry$shot_made_flag == "n"] <- "shot_no"
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "shot_yes"

#################################################################################################
# Add a column minute that contains the minute number where a shot occurred. 
# For instance, if a shot took place during period = 1 and minutes_remaining = 8, 
# then this should correspond to a value minute = 4. Likewise, if a shot took place 
# during period = 4 and minutes_remaining = 2 then this should correspond to a value minute = 46. 
#################################################################################################

iguodala$minute <- iguodala$period * 12 - iguodala$minutes_remaining
green$minute <- green$period * 12 - green$minutes_remaining
durant$minute <- durant$period * 12 - durant$minutes_remaining
thompson$minute <- thompson$period * 12 - thompson$minutes_remaining
curry$minute <- curry$period * 12 - curry$minutes_remaining

##################################################################################
# Use sink() to send the summary() output of each imported data frame into 
# individuals text files: andre-iguodala-summary.txt, draymond-green-summary.txt, 
# etc. Dur- ing each sinking operation, the produced summaries should be sent to 
# the output/ folder using relative paths.
##################################################################################

sink("../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

sink("../output/draymond-green-summary.txt")
summary(green)
sink()

sink("../output/kevin-durant-summary.txt")
summary(durant)
sink()

sink("../output/klay-thompson-summary.txt")
summary(thompson)
sink()

sink("../output/stephen-curry-summary.txt")
summary(curry)
sink()

###################################################################################
# (1) Use the row binding function rbind() to stack the tables into one single 
#     data frame (or tibble object). 
# (2) Export (i.e. write) the assembled table as a CSV file shots-data.csv inside 
#     the folder data/. Use a relative path for this operation. 
# (3) Use sink() to send the summary() output of the assembled table. Send this 
#     output to a text file named shots-data-summary.txt inside the output/ folder. 
#     Use a relative path when exporting the R output. 
###################################################################################

# combine dataframe
shots_data <- rbind(curry, durant, green, iguodala, thompson)

# export the assembled table
write.csv(shots_data, file = "../data/shots-data.csv")

# export summary information
sink("../output/shots-data-summary.txt")
summary(shots_data)
sink()