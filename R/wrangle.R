
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

save(sample_tidied_framingham, file = "datasets/sample_tidied_framingham.rda")
save(tidied_framingham, file = "datasets/tidied_framingham.rda")

# For chapter 4 -----------------------------------------------------------

library(lme4)
library(broom)
library(furrr)
library(glue)
plan(multiprocess)

# Prepare the data for the modeling
tidied_framingham_v02 <- tidied_framingham %>%
    mutate_at(
        vars(
            systolic_blood_pressure,
            diastolic_blood_pressure,
            fasting_blood_glucose,
            total_cholesterol,
            body_mass_index
        ),
        funs(as.numeric(scale(.)))
    ) %>%
    rename_at(
        vars(
            systolic_blood_pressure,
            diastolic_blood_pressure,
            fasting_blood_glucose,
            total_cholesterol,
            body_mass_index
        ),
        funs(str_c("scaled_", .))
    ) %>%
    mutate(participant_age = mean_center(participant_age))

# Set predictors and covariates for model formulas.
predictors <- tidied_framingham_v02 %>%
    select(matches("^scaled_"), -scaled_body_mass_index) %>%
    names()

covariates <- tidied_framingham_v02 %>%
    select(education_combined, currently_smokes, sex, participant_age) %>%
    names() %>%
    str_c(collapse = " + ")

base_covariates <- "followup_visit_number + (1 | subject_id)"

# Function to extract model results from glmer
extract_results_lme <- function(.x) {
        model <- glmer(.x, family = binomial, data = tidied_framingham_v02)
        model %>%
            tidy(conf.int = TRUE) %>%
            mutate(outcome = as.character(model@call$formula[[2]]),
                   predictor = term[2]) %>%
            select(outcome, predictor, everything())
}

# Generate model results from all possible formulas.
unadjusted_models <- predictors %>%
    map(~ as.formula(glue("got_cvd ~ {.x} + {base_covariates}"))) %>%
    future_map(~ extract_results_lme(.x)) %>%
    bind_rows()

adjusted_models <- predictors %>%
    map(~ as.formula(glue("got_cvd ~ {.x} + {covariates} + {base_covariates}"))) %>%
    future_map(~ extract_results_lme(.x)) %>%
    bind_rows()

# Combine unadjusted and adjusted models into single dataframe
all_models <- bind_rows(
    unadjusted_models %>% mutate(model = "Unadjusted"),
    adjusted_models %>% mutate(model = "Adjusted")
    ) %>%
    mutate_at(vars(estimate, conf.low, conf.high), funs(exp(.))) %>%
    select(model, outcome, predictor, term, estimate, conf.low, conf.high)

# Save the model results:
# save(unadjusted_models, file = "datasets/unadjusted_models.rda")
# save(adjusted_models, file = "datasets/adjusted_models.rda")
save(all_models, file = "datasets/all_models.rda")

# Function to extract interaction model results from glmer
extract_interaction_lme <- function(.x) {
        model <- glmer(.x, family = binomial, data = tidied_framingham_v02)
        model %>%
            tidy(conf.int = TRUE) %>%
            mutate(outcome = as.character(model@call$formula[[2]]),
                   predictor = term[2]) %>%
            select(outcome, predictor, everything()) %>%
            filter(str_detect(term, ":"))
}

# Generate model results for interaction by time
interaction_by_time <- predictors %>%
    map(~ as.formula(glue("got_cvd ~ {.x} + {base_covariates} + {.x}:followup_visit_number"))) %>%
    future_map(~ extract_interaction_lme(.x)) %>%
    bind_rows()

# Generate model results for interaction by time
interaction_by_sex <- predictors %>%
    map(~ as.formula(glue("got_cvd ~ {.x} + {base_covariates} + {.x}*sex"))) %>%
    future_map(~ extract_interaction_lme(.x)) %>%
    bind_rows()

interaction_models <- bind_rows(
    interaction_by_sex %>% mutate(interaction = "sex"),
    interaction_by_time %>% mutate(interaction = "followup_visit_number")
    ) %>%
    select(interaction, outcome, predictor, term, estimate, std.error,
           conf.low, conf.high, p.value)

# Save interaction results
save(interaction_models, file = "datasets/interaction_models.rda")

# int <- predictors[4] %>%
#     map(~ as.formula(glue("got_cvd ~ {.x} + followup_visit_number*sex*{.x} + (1 | subject_id)"))) %>%
#     future_map(~ extract_interaction_lme(.x)) %>%
#     bind_rows()
# save(int, file = "datasets/checkinto.rda")
