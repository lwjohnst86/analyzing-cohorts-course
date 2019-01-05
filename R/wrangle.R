
library(tidyverse, quietly = TRUE)

# Unzip and load in the framingham dataset
framingham <- read_csv(unz("data-raw/framingham.zip", "FRAMINGHAM_csv/frmgham2.csv"))

# For chapter 1 -----------------------------------------------------------

# Convert column names to lower case
framingham <- framingham %>%
    rename_all(str_to_lower)

save(framingham, file = "datasets/framingham.rda")


# For chapter 2 -----------------------------------------------------------

# Rename all the variables
tidier_framingham <- framingham %>%
    rename(
        subject_id = randid,
        systolic_blood_pressure = sysbp,
        diastolic_blood_pressure = diabp,
        cigarettes_per_day = cigpday,
        blood_pressure_meds = bpmeds,
        heart_rate = heartrte,
        fasting_blood_glucose = glucose,
        education = educ,
        days_since_first_visit = time,
        prevalent_chd = prevchd,
        prevalent_mi = prevmi,
        prevalent_stroke = prevstrk,
        prevalent_hypertension = prevhyp,
        prevalent_angina = prevap,
        hospitalized_mi = hospmi,
        hospitalized_mi_fatal_chd = mi_fchd,
        any_chd_event = anychd,
        any_cerebral_stroke_event = stroke,
        hypertension = hyperten,
        high_density_lipoprotein = hdlc,
        low_density_lipoprotein = ldlc,
        got_cvd = cvd,
        total_cholesterol = totchol,
        body_mass_index = bmi,
        participant_age = age,
        currently_smokes = cursmoke,
        followup_visit_number = period
    )

save(tidier_framingham, file = "datasets/framingham_tidier.rda")

# For chapter 3 -----------------------------------------------------------

mean_center <- function(x) {
    as.numeric(scale(x, scale = FALSE))
}

tidied_framingham <- tidier_framingham %>%
    select(-matches("^time")) %>%
    mutate(
        education = case_when(
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_),
        # Convert the values for sex
        sex = case_when(
            sex == 1 ~ "Man",
            sex == 2 ~ "Woman",
            TRUE ~ NA_character_),
        education_combined = fct_recode(
            education,
            # Form is: "new" = "old"
            "Post-Secondary" = "College",
            "Post-Secondary" = "Vocational"
        ),
        centered_total_cholesterol = mean_center(total_cholesterol),
        centered_systolic_blood_pressure = mean_center(systolic_blood_pressure),
        centered_body_mass_index = mean_center(body_mass_index),
        centered_fasting_blood_glucose = mean_center(fasting_blood_glucose)
        )

ids <- unique(tidied_framingham$subject_id)
sampled_ids <- sample(ids, length(ids) / 15, replace = FALSE)
sample_tidied_framingham <- tidied_framingham %>%
    filter(subject_id %in% sampled_ids)

save(tidied_framingham, sample_tidied_framingham,
     file = "datasets/tidied_framingham.rda")
