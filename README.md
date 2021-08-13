
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Projeto final do curso de Web Scraping

<img src='man/fig/theoffice.png' align="center" height="139" /></a>
<!-- badges: start --> <!-- badges: end -->

Esse pacote foi produzido especialmente para o trabalho final do curso
de Web Scraping. [curso-r](https://curso-r.com/).

## Instalação

``` r
# install.packages("devtools")
devtools::install_github("katerine-dev/scraperTheoffice")
```

## Descrição

O objetivo do trabalho era scrapear alguma página que resultaria em uma
base de dados. Foi escolhida a página do Wikipédia que contém a lista
completa dos episódios de totas as temporadas da série [The
Office](https://pt.wikipedia.org/wiki/Lista_de_epis%C3%B3dios_de_The_Office_(Estados_Unidos)).

Para manter a consistência da atividade foi escolhido não utilizar a API
documentada do Wikipédia.

## Passos

-   1º Passo: Utilizando a ferramenta inspeccionar foi identificado que
    os dados eram constituídos em formato de `/table`.
-   2° Passo: Scrapear e parsear os dados.
-   3º Passo: Limpeza da base de dados.
-   4º Passo: Foi disponibilizada a base tidy no pacote.

## Base Tidy

``` r
#scrapperTheoffice::baseTheoffice |> 
#  dplyr::glimpse()
```

Em resultado do scraper obtive uma base com 163 linhas e 9 variaveis: (a
base foi devidamente documentada: `R/utils-data`)

| Coluna              | Descrição                                                          |
|---------------------|--------------------------------------------------------------------|
| `temporada`         | Temporada do episódio correspondente.                              |
| `n_total`           | Número do episódio correspondente ao total de todas as temporadas. |
| `n_episodio`        | Número do episódio correspondente a temporada.                     |
| `dirigido_por`      | Diretor do episódio.                                               |
| `escrito_por`       | Escritor do roteiro do episódio.                                   |
| `audiencia`         | Número da audiência na data de exibicao original.                  |
| `codigo`            | Código referente ao episódio.                                      |
| `exibicao_original` | A data da exibicão original do episodio.                           |

## Análise descritiva e resultados

tabela com os episódios com mais audiência.
