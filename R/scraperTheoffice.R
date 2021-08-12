
# Scraper ---------------------------------------------------------------------------------------------------------------------------------------

URL_BASE <- "https://pt.wikipedia.org/wiki/"

endpoint <- "Lista_de_episódios_de_The_Office_(Estados_Unidos)"

url_completa <- paste0(URL_BASE, endpoint)

response <-
  httr::GET(url_completa, httr::write_disk("output/theoffice.html")) # guarda html

html_file <- rvest::read_html("output/theoffice.html")

tabelas <-  html_file |>
  rvest::html_nodes("table") |>
  rvest::html_table() |>
  tibble::enframe() |>
  dplyr::filter(name >= 3,
                name <= 9) |>
  dplyr::mutate(value = purrr::map(
    value,
    setNames,
    c(
      "n_total",
      "n_episodio",
      "titulo",
      "dirigido_por",
      "escrito_por",
      "audiencia",
      "codigo",
      "exibicao_original"
    )
  )) |>
  dplyr::mutate(value = purrr::map(value, ~ dplyr::mutate(.x, n_total = as.character(n_total)))) |>
  dplyr::mutate(value = purrr::map(value, ~ dplyr::mutate(.x, n_episodio = as.character(n_episodio)))) |>
  dplyr::mutate(value = purrr::map(value, ~ dplyr::mutate(.x, codigo = as.character(codigo)))) |>
  tidyr::unnest(value) |>
  dplyr::mutate(name = as.character(name)) |>
  dplyr::mutate(
    name = dplyr::case_when(
      stringr::str_detect(name, stringr::regex("3")) ~ "1ª temporada",
      stringr::str_detect(name, stringr::regex("4")) ~ "2ª temporada",
      stringr::str_detect(name, stringr::regex("5")) ~ "3ª temporada",
      stringr::str_detect(name, stringr::regex("6")) ~ "4ª temporada",
      stringr::str_detect(name, stringr::regex("7")) ~ "5ª temporada",
      stringr::str_detect(name, stringr::regex("8")) ~ "6ª temporada",
      stringr::str_detect(name, stringr::regex("9")) ~ "7ª temporada",
     TRUE ~ name
    )
  )

tabelas_plain <- html_file |>
  rvest::html_nodes("table.wikitable.plainrowheaders") |>
  rvest::html_table() |>
  tibble::enframe() |>
  dplyr::mutate(value = purrr::map(
    value,
    setNames,
    c(
      "n_total",
      "n_episodio",
      "titulo",
      "dirigido_por",
      "escrito_por",
      "audiencia",
      "codigo",
      "exibicao_original"
    )
  )) |>
  tidyr::unnest(value) |>
  dplyr::filter(!stringr::str_detect(n_total, "[a-zA-Z]")) |>
  dplyr::mutate(name = as.character(name)) |>
  dplyr::mutate(name =  stringr::str_replace(name, "1", "8ª temporada"))



# join ------------------------------------------------------------------------------------------------------------------------------------------

tabelas_prontas <- tabelas |>
  dplyr::full_join(tabelas_plain)



