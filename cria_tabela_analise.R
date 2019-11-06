library("tidyverse")
path <- "~/Documents/data-science/TSE-eleicoes-2018/suelio/"

import_csv <- function(path, file){
  path %>%
    paste0(file) %>%
    read_csv2() %>%
    as_tibble()
}

receitas_candidatos <- import_csv(path, "receitas_candidatos_2018_CE_utf8.csv")
despesas_contratadas <- import_csv(path, "despesas_contratadas_candidatos_2018_CE_utf8.csv")
consulta_cand <- import_csv(path, "consulta_cand_2018_CE_utf8.csv")

receita_total_candidatos <- receitas_candidatos %>%
  group_by(NR_CPF_CANDIDATO, NM_CANDIDATO, DS_CARGO, SG_PARTIDO) %>%
  summarize(receita_total = sum(VR_RECEITA))

despesas_contratadas_total <- despesas_contratadas %>%
  group_by(NR_CPF_CANDIDATO) %>%
  summarize(despesa_total = sum(VR_DESPESA_CONTRATADA))

candidatos_situacao <- consulta_cand %>%
  select(NR_CPF_CANDIDATO, DS_SIT_TOT_TURNO) %>%
  filter(DS_SIT_TOT_TURNO != "#NULO#")



candidatos_receita_despesa <- receita_total_candidatos  %>%
  inner_join(despesas_contratadas_total, by=c("NR_CPF_CANDIDATO","NR_CPF_CANDIDATO")) %>%
  inner_join(candidatos_situacao, by=c("NR_CPF_CANDIDATO","NR_CPF_CANDIDATO"))


candidatos_receita_despesa_final <- candidatos_receita_despesa %>%
  mutate(DS_SIT_TOT_TURNO = case_when(
    DS_SIT_TOT_TURNO == "NÃO ELEITO" ~ 1,
    DS_SIT_TOT_TURNO == "SUPLENTE" ~ 2,
    DS_SIT_TOT_TURNO == "ELEITO POR MÉDIA" ~ 3,
    DS_SIT_TOT_TURNO == "ELEITO POR QP" ~ 4,
    DS_SIT_TOT_TURNO == "ELEITO" ~ 5,
    TRUE ~ -1
  ))
