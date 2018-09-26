
# Run this when in the project.
library(tidyverse)
framingham <- read_csv(unz("data-raw/framingham.zip", "FRAMINGHAM_csv/frmgham2.csv")) %>%
    rename_all(str_to_lower)

save(framingham, file = "datasets/framingham.rda")
