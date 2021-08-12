URL_BASE <- "https://pt.wikipedia.org/wiki/"

endpoint <- "Lista_de_episódios_de_The_Office_(Estados_Unidos)"

url_completa <- paste0(URL_BASE, endpoint)

response <-
  httr::GET(url_completa, httr::write_disk("output/theoffice.html"))

html_file <- rvest::read_html("output/theoffice.html")

library(tidyverse)
library(tidyselect)

tabelas <-  html_file |>
  rvest::html_nodes("table.wikitable.noprint.plainlinks.unsortable.uncollapsible") |>
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
  dplyr::mutate(value = purrr::map(value, ~ dplyr::mutate(.x, n_total = as.character(n_total)))) |>
  dplyr::mutate(value = purrr::map(value, ~ dplyr::mutate(.x, n_episodio = as.character(n_episodio)))) |>
  dplyr::mutate(value = purrr::map(value, ~ dplyr::mutate(.x, codigo = as.character(codigo)))) |>
  tidyr::unnest(value)

tabelas_restante <- html_file |>
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
  dplyr::filter(!str_detect(n_total, "[a-zA-Z]"))

tabelas_prontas <- tabelas |>
  dplyr::full_join(tabelas_restante)
