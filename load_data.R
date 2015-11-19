#--------------------------------------------------------------------
# load_data.R
# download data & extract them
#
# 19.XI.2015 tbr
#
#--------------------------------------------------------------------
zipfile <- "./data/dataset.zip"
if (!file.exists(zipfile)) {
    if (!file.exists("data")) { dir.create("data")}
    www = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    print("download zipfile...")
    download.file(www, destfile=zipfile, method="curl")
}
if (!file.exists("UCI HAR Dataset")) {
    print("unzip files...")
    unzip(zipfile)
}
rm(www, zipfile)