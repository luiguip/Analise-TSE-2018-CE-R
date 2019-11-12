boxplot_receita <- ggplot(candidatos_receita_despesa, aes(DS_SIT_TOT_TURNO, receita_total))
boxplot_receita + geom_boxplot()

boxplot_despesa <- ggplot(candidatos_receita_despesa, aes(DS_SIT_TOT_TURNO, despesa_total))
boxplot_despesa + geom_boxplot()

dispersao_receita_despesa <- ggplot(candidatos_receita_despesa %>% filter(str_detect(DS_SIT_TOT_TURNO, "ELEITO")) , aes(receita_total, despesa_total, colour = DS_SIT_TOT_TURNO))
dispersao_receita_despesa + geom_point()

dispersao_situacao_receita <- ggplot(candidatos_receita_despesa_final, aes(receita_total, DS_SIT_TOT_TURNO))
dispersao_situacao_receita + geom_point() + stat_smooth(method="lm", col="red")

candidatos_sem_gs <- candidatos_receita_despesa_final %>%
  filter(!(DS_CARGO %in% c("Senador", "Governador")))

dispersao_situacao_receita_semgs <- ggplot(candidatos_sem_gs, aes(receita_total, DS_SIT_TOT_TURNO))
dispersao_situacao_receita_semgs + geom_point() + stat_smooth(method="lm", col="red")

