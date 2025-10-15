## for our economic index, see how covid 19 cases affected economic activity (in switzerland)
rm(list = ls())

library(httr2)



## Step 1: get covid case counts over all time for a country 

get_case_counts <- function(country = "CH", period = c(30,365, "all")){
  # "https://disease.sh/v3/covid-19/historical/CH?lastdays=30"
  # this way is error prone, try to match.args to check if the inputs are correct
  base_url <- "https://disease.sh/v3/covid-19/historical"
  final_url <- paste0(base_url, "/", country, "?lastdays=", period)

  # perform API call with httr2
  req <- request(final_url) 
  resp <- req_perform(req)

  # if request is not successful
  if (resp_status(resp) != 200){
    message("The request was not successful")
  }
  else{
    return(resp_body_json(resp))
  }
}

get_case_counts("AUT", "all")

## Step 2: get vaccine rates

get_country_vaccine_rates <- function(country = "CH", period = c(30,365, "all")){
  # https://disease.sh/v3/covid-19/vaccine/coverage/countries/CH?lastdays=30&fullData=false
  # this way is error prone, try to match.args to check if the inputs are correct
  base_url <- "https://disease.sh/v3/covid-19/vaccine/coverage/countries"
  final_url <- paste0(base_url, "/", country, "?lastdays=", period, "&fullData=false")

  # perform  API call with httr2
  req <- request(final_url) 
  resp <- req_perform(req)

  # if request is not successful
  if (resp_status(resp) != 200)){
    message("The request was not successful")
  }
  else{
    return(resp_body_json(resp))
  }

}

get_country_vaccine_rates("CH", 30)

