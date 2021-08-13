# Limpeza -----------------------------------------------------------------------------------------------------------------------------------

baseTheoffice <- tabelas_prontas |>
  dplyr::rename(temporada = name) |>
  dplyr::mutate(audiencia = stringr::str_remove(audiencia, stringr::regex("\\[[0-9]+\\]"))) |>
  dplyr::mutate(dplyr::across(c(audiencia,
                                n_total,
                                n_episodio), as.numeric)) |>
  dplyr::mutate(exibicao_original = stringr::str_remove(exibicao_original, stringr::regex("\\[[0-9]+\\]\\[[0-9]+\\]|\\[[0-9]+\\]|(?<=\\().+?(?=\\))|\\(.*|[\\(\\)]"))) |>
  dplyr::mutate(exibicao_original = (lubridate::dmy(exibicao_original)))


usethis::use_data(baseTheoffice, overwrite = TRUE)
