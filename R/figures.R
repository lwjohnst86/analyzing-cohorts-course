
# Chapter 1, slide 1, figure for prospective cohort

library(tidyverse)

disease_occurrence <- tibble(
    Participant = fct_inorder(as.character(1:20)),
    Status = sample(c(rep("Disease", times = 8),
                      rep("Healthy", times = 12)),
                    replace = FALSE),
    DiseaseTime = sample(5:14, size = 20, replace = TRUE),
    Time = if_else(Status == "Healthy", 16L, DiseaseTime)
)

pro_cohort_visual <- disease_occurrence %>%
    ggplot(aes(y = Participant, xmax = Time, xmin = 0, colour = Status)) +
    geom_errorbarh(height = 0, size = 1) +
    geom_point(aes(x = Time)) +
    geom_vline(xintercept = 15, linetype = "dotted") +
    geom_vline(xintercept = 0, linetype = "solid") +
    coord_cartesian(
        xlim = c(-0.5, 15),
        ylim = c(0, nrow(disease_occurrence) + 0.5),
        expand = FALSE
    ) +
    scale_x_continuous(breaks = c(0, 15), labels = c("Start", "End")) +
    labs(x = "Follow-up time", title = "Participants in prospective cohort") +
    theme(
        panel.background = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        plot.title = element_text(size = 10),
        axis.title.x = element_text(size = 10),
        legend.title = element_blank(),
        legend.key = element_blank()
    )

ggsave("datasets/prospective-cohort-visual-example.pdf", pro_cohort_visual)

