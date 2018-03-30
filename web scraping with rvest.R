#web scraping with rvest

install.packages("rvest")
install.packages("lubridate")
install.packages("dplyr")

library(rvest)
library(lubridate)
library(dplyr)

#create 'weather' using read_html(https://www.wunderground.com/history/airport/EGLL/2018/3/15/DailyHistory.html?req_city=&req_state=&req_statename=&reqdb.zip=&reqdb.magic=&reqdb.wmo=)
weather = read_html('https://www.wunderground.com/history/airport/EGLL/2018/3/15/DailyHistory.html?req_city=&req_state=&req_statename=&reqdb.zip=&reqdb.magic=&reqdb.wmo=')

#create weather_node which is the nodes of the webpage
weather_nodes = html_nodes(weather, '.wx-value')

#create weather_text which is the text of this webpage
weather_text = html_text(weather_nodes)

#create 'mean_temp' which is the mean temperature from this webpage
mean_temp = weather_text[1]

#create a list of dates from 2018-02-01 to 2018-02-28
dates = seq(as.Date("2018-02-01"), as.Date("2018-02-28"), by="days")

#create a list of URLs with the dates 2018-02-01 to 2018-02-28
urls = paste0('https://www.wunderground.com/history/airport/EGLL/',
                   year(dates),
              '/',
              month(dates),
              '/',
              day(dates),
'/DailyHistory.html?req_city=&req_state=&req_statename=&reqdb.zip=&reqdb.magic=&reqdb.wmo=')

#create 'feb_2018_temp' which is the mean temperature for each day in February 2018
feb_2018_temp = rep(NA, 28)
for(i in 1:28){
  weather = read_html(urls[i])
  weather_nodes = html_nodes(weather, '.wx-value')
  
  weather_text = html_text(weather_nodes)
  feb_2018_temp[i] = weather_text[1]
}


