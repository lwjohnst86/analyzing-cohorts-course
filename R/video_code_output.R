


# Chapter 2 video 3 -------------------------------------------------------

library(tidyverse)
library(patchwork)
library(rlang)
library(Epi)
data("diet")
# summary(diet)

diet <- as_tibble(diet)
invert <- function(x) 1 / x
transformed <- diet %>%
    mutate_at(vars(weight, height), funs(scale, log, invert))

## Variable names
transformed %>%
    select(matches("weight|height"), -contains("invert")) %>%
    names()

## Histogram and density

histo_density <- function(.data, x) {
    xvar <- enquo(x)
    ggplot(transformed, aes(x = !!xvar, y = stat(density))) +
        geom_histogram(colour = "black", fill = "lightblue", size = 0.25) +
        geom_density()
}

histo_density(transformed, weight) +
    histo_density(transformed, weight_scale) + ylab("") +
    histo_density(transformed, weight_log) +
    histo_density(transformed, weight_invert) + ylab("")

ggsave("datasets/plot_transform_weight.png")
