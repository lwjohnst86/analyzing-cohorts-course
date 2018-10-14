
library(tidyverse, quietly = TRUE)

# Unzip and load in the framingham dataset
framingham <- read_csv(unz("data-raw/framingham.zip", "FRAMINGHAM_csv/frmgham2.csv"))


# Data for chapter 1 ------------------------------------------------------

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
        cigerattes_per_day = cigpday,
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
