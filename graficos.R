boxplot_eleito <- ggplot(candidatos_receita_despesa, aes(DS_SIT_TOT_TURNO, receita_total))
boxplot_eleito + geom_boxplot()
boxplot_eleito + geom_point()

dispersao_receita_despesa <- ggplot(candidatos_receita_despesa %>% filter(str_detect(DS_SIT_TOT_TURNO, "ELEITO")) , aes(receita_total, despesa_total, colour = DS_SIT_TOT_TURNO))
dispersao_receita_despesa + geom_point()
