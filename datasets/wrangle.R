
# Run this when in the project.
library(tidyverse)
framingham <- read_csv(unz("datasets/raw/framingham.zip", "FRAMINGHAM_csv/frmgham2.csv")) %>%
    rename_all(str_to_lower) %>%
    select(randid, time, period, sex, totchol, age, cursmoke, cigpday, bmi, educ,
           prevchd, prevmi, prevstrk, hdlc, cvd, timecvd) %>%
    mutate(sex = fct_recode(as_factor(as.character(sex)), Man = "1", Woman = "2"),
           educ = case_when(
               educ == 1 ~ "0-11 years",
               educ == 2 ~ "High School",
               educ == 3 ~ "Vocational",
               educ == 4 ~ "College",
               TRUE ~ NA_character_
               )
           )

save(framingham, file = "datasets/framingham.rda")

library(Epi)
data("diet")
dietchd <- diet
save(dietchd, file = "datasets/dietchd.rda")
