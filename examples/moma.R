# example query: https://collectionapi.metmuseum.org/public/collection/v1/search?q=bread
# for more detail on this example, see: https://rse-book.github.io/case-studies.html#build-your-own-api-wrapper

library(httr2)
library(jsonlite)


## Step 1: Search for objects related to "bread"

#' Search MET
#'
#' This function searches the MET's archive
#' for keywords and returns object ids of
#' search hits. It is a simple wrapper
#' around the MET's Application Programming
#' interface (API). The function is designed 
#' to work with other API wrappers
#' and use object ids as an input.
#' 
#' @param character search term
#' @return list containing the total 
#' number of objects found and a 
#' vector of object ids.
search_met <- function(keyword = NULL){
  base_url <- "https://collectionapi.metmuseum.org/public/collection/v1/search?q="
  # simplified matt's function for students
  url_with_param <- paste0(base_url, keyword)
  # get json objects to r object
  jsonlite::fromJSON(url_with_param)

}

search_met("bread")

example url "https://collectionapi.metmuseum.org/public/collection/v1/search?q=bread"


## Step 2: get actual paintings



## ------------------------- minna tries

download_met_images_by_id_mi <- 
  function(id,
           download = "primaryImage",
           path = "met"){

    uri <- "https://collectionapi.metmuseum.org/public/collection/v1/objects/%d"
    req <- download.file(sprintf(uri,
    id),destfile = "temp.json")
    jsonlite::fromJSON("temp.json")


           }

## ------------------------- matt's 

download_met_images_by_id <- 
  function(ids,
           download = "primaryImage",
           path = "met") {
  # Obtain meta description objects from MET API
  obj_list <- lapply(ids, function(x) {

'    ids <- 893201'
    uri <- "https://collectionapi.metmuseum.org/public/collection/v1/objects/%d"
    req <- download.file(sprintf(uri,
    x),destfile = "temp.json")
    jsonlite::fromJSON("temp.json")
  })
  
  
  public <- sapply(obj_list, "[[", "isPublicDomain")
  
  
  # Extract the list elements that contains
  # img URLs in order to pass it to the download function
  img_urls <- lapply(obj_list, "[[", download)
  
  # Note the implicit return, no return statement needed
  # last un-assigned statement is returned
  # from the function
  for (x in unlist(img_urls[public])){
    download.file(x, destfile = sprintf("%s/%s",
     path, basename(x)))
  }
  
  
  message(
    sprintf("
    The following images ids were not public
    domain and could not be downloaded:\n %s",
            paste(ids[!public], collapse = ",")
  ))
  
  message(
    sprintf("
    The following images ids were public
    domain and could be downloaded to\n %s: %s",
            path, paste(ids[public], collapse = ",")
  ))
  
}


# loop through list of objectIDs returned by the search_met function to get some images (many non-public)

for (id in search_met("bread")$objectIDs){
 download_met_images_by_id(id) 
}

id <- search_met("bread")$objectIDs[1]
download_met_images_by_id(id)


bread_ids <- search_met("bread")$objectIDs[1:10]

download_met_images_by_id(test_id)
test_id <- "893201"