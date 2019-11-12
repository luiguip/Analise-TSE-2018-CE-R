candidatos_sem_gs <- candidatos_receita_despesa %>%
  filter(!(DS_CARGO %in% c("Senador", "Governador")))

boxplot_receita <- ggplot(candidatos_sem_gs, aes(DS_SIT_TOT_TURNO, receita_total))
boxplot_receita + geom_boxplot()
boxplot_receita + geom_violin()
ggplot(candidatos_sem_gs, aes(DS_SIT_TOT_TURNO, receita_total, size=DS_SIT_TOT_TURNO)) + geom_point()
boxplot_receita + geom_bar(stat = "summary", fun.y = "mean")
