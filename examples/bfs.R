# devtools::install_github("lgnbhl/BFS")
# library(BFS)
# library(tidyverse)

# View(bfs_get_catalog_data(language = "en", title = "savings"))

# ?bfs_get_sse_data


# # example: get all energy related datasets

# # check all english datasets
# # View(bfs_get_catalog_data(language = "en"))

# View(bfs_get_catalog_data(language = "en", title = "energy"))

# dataset_nr <- "px-x-0204000000_106"

# energy_df <- bfs_get_data(dataset_nr, lang = "en")
# View(energy_df)

# # filter only total energy "Energy product - Total" & keep only year & "Energy accounts of economy and households"
# total_energy <- energy_df |>
#   # get only total for each category
#   filter(`Economy and households` == "Economy and households - Total") |>
#   filter(`Energy product` == "Energy product - Total") |>
#   # rename Energy accounts of economy and households to amount
#   select(Year, Amount = `Energy accounts of economy and households`)

# View(total_energy)

# advantage: get all by one go, filter, redo - always get up to date, reproducible, etc. 

library(tidyverse)
library(BFS)

bfs_get_catalog_data(language = "en", title = "energy")
dataset_nr <- "px-x-0204000000_106"
energy_df <- bfs_get_data(dataset_nr, lang = "en")

# filter only total energy accounts
total_energy <- energy_df |>
  # get only total for each category
  filter(`Economy and households` == "Economy and households - Total") |>
  filter(`Energy product` == "Energy product - Total") |>
  # rename Energy accounts of economy and households to amount
  select(Year, Amount = `Energy accounts of economy and households`)

View(total_energy)


api_url <- "https://www.pxweb.bfs.admin.ch/api/v1/en/px-x-0204000000_106/px-x-0204000000_106.px"