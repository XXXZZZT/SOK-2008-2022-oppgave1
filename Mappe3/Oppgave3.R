
  
library(tidyverse)  
library(dplyr)
library(snakecase)
library(ggrepel)
library(rjson)
library(janitor)
library(snakecase)
library(lubridate)
library(rjstat)
library(pacman)

getwd()

url <- "https://data.ssb.no/api/v0/no/table/11155/" 

data <- '
  {
  "query": [
    {
      "code": "Kjonn",
      "selection": {
        "filter": "item",
        "values": [
          "0",
          "1",
          "2"
        ]
      }
    },
    {
      "code": "Alder",
      "selection": {
        "filter": "item",
        "values": [
          "20-64",
          "15-24"
        ]
      }
    },
    {
      "code": "UtdNivaa",
      "selection": {
        "filter": "item",
        "values": [
          "TOT"
        ]
      }
    },
    {
      "code": "ContentsCode",
      "selection": {
        "filter": "item",
        "values": [
          "ArbLedigProsent"
        ]
      }
    },
    {
      "code": "Tid",
      "selection": {
        "filter": "item",
        "values": [
          "2020"
        ]
      }
    }
  ],
  "response": {
    "format": "json-stat2"
  }
  }
'
d.tmp <- POST(url, body = data, encode = 'json', verbose())
