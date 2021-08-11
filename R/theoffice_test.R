URL_BASE <- "https://pt.wikipedia.org/wiki/"

endpoint <- "Lista_de_episódios_de_The_Office_(Estados_Unidos)"

url_completa <- paste0(URL_BASE, endpoint)

response <-
  httr::GET(url_completa, httr::write_disk("output/theoffice.html"))

html_file <- readr::read_file("output/theoffice.html")


