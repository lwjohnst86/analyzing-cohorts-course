
library(tidyverse)
library(emojifont)
library(ghibli)
color_theme <- ghibli_palette("MononokeMedium")

# Chapter 1, prospective cohort outcomes ----------------------------------

disease_occurrence <- tibble(
    Participant = fct_inorder(as.character(1:20)),
    Status = sample(c(rep("Disease", times = 8),
                      rep("Healthy", times = 12)),
                    replace = FALSE),
    DiseaseTime = sample(5:14, size = 20, replace = TRUE),
    Time = if_else(Status == "Healthy", 16L, DiseaseTime)
)

pro_cohort_visual_plot <- disease_occurrence %>%
    ggplot(aes(y = Participant, xmax = Time, xmin = 0, colour = Status)) +
    geom_errorbarh(height = 0, size = 0.8) +
    geom_point(aes(x = Time)) +
    geom_vline(xintercept = 15, linetype = "dotted") +
    geom_vline(xintercept = 0, linetype = "solid") +
    coord_cartesian(
        xlim = c(-0.5, 15),
        ylim = c(0, nrow(disease_occurrence) + 0.5),
        expand = FALSE
    ) +
    scale_x_continuous(breaks = c(0, 15), labels = c("Start", "End")) +
    scale_colour_manual(values = color_theme[c(6, 3)]) +
    labs(x = "Follow-up time", title = "Participants in prospective cohort") +
    theme(
        panel.background = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        # plot.title = element_text(),
        # axis.title.x = element_text(),
        legend.title = element_blank(),
        legend.key = element_blank()
    )
ggsave("datasets/plot-prospective-outcome.png", dpi = 90)

# Chapter 1, cohort sample plot -------------------------------------------

fa <- fontawesome(c('fa-user-md', 'fa-user'))
fa_data <-
    tibble(
        x = rnorm(20, sd = 1.5),
        y = rnorm(20, sd = 1.5),
        label = sample(fa, 20, replace = TRUE)
    )

cohort_sample_plot <- ggplot(fa_data, aes(x, y, color = label, label = label)) +
    geom_text(family = 'fontawesome-webfont', size = 8, show.legend = FALSE) +
    labs(x = NULL, y = NULL) +
    theme(legend.text = element_text(family = 'fontawesome-webfont'),
          legend.position = "none") +
    scale_color_manual(values = color_theme[c(3, 6)]) +
    theme_void()
ggsave("datasets/plot-cohort-sample.png", dpi = 90)

# Chapter 1, purpose of cohorts plots -------------------------------------

base_background <- ggplot() +
    theme_void()

heart_plot <- base_background +
    geom_fontawesome('fa-heartbeat', color = color_theme[3], size = 90)
ggsave("datasets/plot-purpose-risk-factors.png", dpi = 90)

doctor_plot <- base_background +
    geom_fontawesome('fa-stethoscope', color = color_theme[3], size = 90)
ggsave("datasets/plot-purpose-diagnosis.png", dpi = 90)

side_effects_plot <- base_background +
    geom_fontawesome('fa-hospital-o', color = color_theme[3], size = 80)
ggsave("datasets/plot-purpose-side-effects.png", dpi = 90)


# Chapter 1, incidence vs prevalence --------------------------------------

prev_incid <- tibble(
    Person_1 = c(1, 1, 1),
    Person_2 = c(0, 1, 1),
    Person_3 = c(0, 0, 1),
    Person_4 = c(0, 0, 0),
    Visit = as.character(c(0, 1, 2))
) %>%
    gather(Person, Disease, -Visit) %>%
    mutate(Person = str_remove(Person, "Person_"),
           Disease = if_else(Disease == 0, "Healthy", "Disease"),
           Disease = fct_rev(Disease))

prev_incid_plot <- ggplot(prev_incid,
       aes(
           x = Visit,
           y = Disease,
           group = Person,
           colour = Person
       )) +
    geom_line() +
    scale_color_manual(values = rev(color_theme)) +
    coord_cartesian(ylim = c(0.75, 2.25), expand = FALSE) +
    theme(
        panel.background = element_blank(),
        panel.grid.major.x = element_line(colour = "grey85"),
        axis.ticks = element_blank(),
        legend.key = element_blank()
    ) +
    labs(y = NULL, x = "Followup visit number",
         title = "Incident vs prevalent cases",
         subtitle = "- Prevalent cases only at given visit\n- Incidence is total new cases")
ggsave("datasets/plot-prevalence-incidence.png", dpi = 90)
