library(RCurl)
library(RJSONIO)
library(utils)
library(XML)
library(plyr)
library(scrapeR)
library(stringr)

#clear existing objects
rm(list=ls(all=TRUE))

#declare variables
data = data.frame()
apikey = list()
apikey$Read = "8Hqho0jaYAKORqd92TCh8vVNUI"
apikey$Write = "1xTSoZUnSiFwlEtdwI4tRiZIuww"
apicall = paste0(URLencode("http://uclassify.com/browse/prfekt/Myers Briggs Judging Function/ClassifyText"),"?")
#webpage = getURL("http://www.deltaattack.com/author/ikecube/"))

# Parse HTML and extract speech text
webpage = getURL("http://www.gamefaqs.com/gba/930370-final-fantasy-vi-advance/faqs/47016",follow=TRUE)
doc = htmlParse(webpage, asText=TRUE)
plain.text <- xpathSApply(doc, "//pre", xmlValue)
txt = paste(plain.text, collapse = "\r")

#build data frame for parsing
data = data.frame(str_locate_all(txt, "\r\n[A-Za-z]*:(\t|  )?"))

#split into columns
d = data.frame(name,line)

for(i in 1:nrow(data))
  {
  linefeed = str_trim(str_replace_all(substr(txt,data[i,1],data[i+1,1]), "\r|\n|\t",""))
  name = str_trim(substr(linefeed, 0, str_locate(linefeed,":")-1))
  line = str_trim(substr(linefeed, str_locate(linefeed,":")+1,str_length(linefeed)))
  newline = data.frame(name, line)
  if(exists("d"))
    {
      d = rbind.fill(d, newline)
    }
  else
    { 
      d = newline
    }
  }

#clear unused variables
rm(data)
rm(newline)
rm(apicall)
rm(apikey)
rm(doc)
rm(i)
rm(line)
rm(linefeed)
rm(name)
rm(namelist)
rm(plain.text)
rm(txt)
rm(webpage)
rm(charcorpus)

#get full script of a character
namelist = as.list(unique(d[1]$name))
lines = ""
for(i in 1:length(namelist))
{
  namelist[7]
  lines = d[d$name=="Wedge",2]
}
lines = ""
lines = d[d$name=="Kefka",2]


# build a row for each name
row = c(Name = "ike")

#Judging Function
apicall = paste0(apicall,"readkey=",apikey$Read,"&text=",URLencode(marker),"&output=json")
result = getURL(apicall)
result = fromJSON(result)
row = as.list(c(row,result$cls1))

#Attitude Function
apicall = paste0(URLencode("http://uclassify.com/browse/prfekt/Myers Briggs Attitude/ClassifyText"),"?")
apicall = paste0(apicall,"readkey=",apikey$Read,"&text=",URLencode(marker),"&output=json")
result = getURL(apicall)
result = fromJSON(result)
row = as.list(c(row,result$cls1))

#Perceiving Function
apicall = paste0(URLencode("http://uclassify.com/browse/prfekt/Myers Briggs Perceiving Function/ClassifyText"),"?")
apicall = paste0(apicall,"readkey=",apikey$Read,"&text=",URLencode(marker),"&output=json")
result = getURL(apicall)
result = fromJSON(result)
row = as.list(c(row,result$cls1))

#Lifestyle Function
apicall = paste0(URLencode("http://uclassify.com/browse/prfekt/Myers Briggs Lifestyle/ClassifyText"),"?")
apicall = paste0(apicall,"readkey=",apikey$Read,"&text=",URLencode(marker),"&output=json")
result = getURL(apicall)
result = fromJSON(result)
row = as.list(c(row,result$cls1))