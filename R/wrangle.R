
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

centered <- function(x) {
    as.numeric(scale(x, scale = FALSE))
}

scaled <- function(x) {
    as.numeric(scale(x, scale = TRUE))
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
        )) %>%
    mutate_at(vars(total_cholesterol, systolic_blood_pressure, body_mass_index, fasting_blood_glucose),
              list(scaled = scaled, centered = centered))

set.seed(1456)
ids <- unique(tidied_framingham$subject_id)
sampled_ids <- sample(ids, length(ids) / 15, replace = FALSE)
sample_tidied_framingham <- tidied_framingham %>%
    filter(subject_id %in% sampled_ids)

save(sample_tidied_framingham, file = "datasets/sample_tidied_framingham.rda")
save(tidied_framingham, file = "datasets/tidied_framingham.rda")

# Even smaller sample size and variable list

ids <- unique(sample_tidied_framingham$subject_id)
sampled_ids <- sample(ids, length(ids) / 3, replace = FALSE)
sample_tidied_framingham <- sample_tidied_framingham %>%
    filter(subject_id %in% sampled_ids)
model_sel_df <- sample_tidied_framingham %>%
    # filter(followup_visit_number == 1) %>%
    select(subject_id, got_cvd, systolic_blood_pressure_scaled, sex,
           body_mass_index_scaled, currently_smokes, followup_visit_number) %>%
    mutate(subject_id = as.character(subject_id)) %>%
    na.omit()

saveRDS(model_sel_df, file = "datasets/model_sel_df.Rds")

# For chapter 4 -----------------------------------------------------------

library(lme4)
library(broom)
library(furrr)
library(glue)
plan(multiprocess)

# Prepare the data for the modeling
tidied_framingham_v02 <- tidied_framingham %>%
    mutate(baseline_age = if_else(followup_visit_number == 1, participant_age, NA_real_) %>%
               centered()) %>%
    arrange(subject_id, followup_visit_number) %>%
    group_by(subject_id) %>%
    fill(baseline_age) %>%
    ungroup()

# Set predictors and covariates for model formulas.
predictors <- tidied_framingham_v02 %>%
    select(matches("_scaled$"), -body_mass_index_scaled) %>%
    names()

covariates <- tidied_framingham_v02 %>%
    select(education_combined, currently_smokes, sex, baseline_age) %>%
    names() %>%
    str_c(collapse = " + ")

base_covariates <- "followup_visit_number + (1 | subject_id)"

# Function to extract model results from glmer
extract_results_simple_lme <- function(.x) {
        model <- glmer(.x, family = binomial, data = tidied_framingham_v02)
        model %>%
            tidy(conf.int = TRUE) %>%
            mutate_at(vars(estimate, std.error, conf.low, conf.high), exp)
}

unadjusted_models_list <- predictors %>%
    map(~ as.formula(glue("got_cvd ~ {.x} + {base_covariates}"))) %>%
    future_map(extract_results_simple_lme, .progress = TRUE)

adjusted_models_list <- predictors %>%
    map(~ as.formula(glue("got_cvd ~ {.x} + {covariates} + {base_covariates}"))) %>%
    future_map(extract_results_simple_lme, .progress = TRUE)

# Save model lists
save(unadjusted_models_list, file = "datasets/unadjusted_models_list.rda")
save(adjusted_models_list, file = "datasets/adjusted_models_list.rda")

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
    future_map(extract_results_lme, .progress = TRUE) %>%
    bind_rows()

adjusted_models <- predictors %>%
    map(~ as.formula(glue("got_cvd ~ {.x} + {covariates} + {base_covariates}"))) %>%
    future_map(extract_results_lme, .progress = TRUE) %>%
    bind_rows()

# Combine unadjusted and adjusted models into single dataframe
all_models <- bind_rows(
    unadjusted_models %>% mutate(model = "Unadjusted"),
    adjusted_models %>% mutate(model = "Adjusted")
    ) %>%
    mutate_at(vars(estimate, conf.low, conf.high), exp) %>%
    select(model, outcome, predictor, term, estimate, conf.low, conf.high)

# Save the model results:
save(all_models, file = "datasets/all_models.rda")

stop("Don't run this next section (interactions)")

# Function to extract interaction model results from glmer
extract_interaction_lme <- function(.x) {
        model <- glmer(.x, family = binomial, data = tidied_framingham_v02)
        model %>%
            tidy(conf.int = TRUE) %>%
            mutate(outcome = as.character(model@call$formula[[2]]),
                   predictor = term[2]) %>%
            select(outcome, predictor, everything())
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

interaction_by_sex_time <- predictors %>%
    map(~ as.formula(glue("got_cvd ~ {.x} + followup_visit_number*sex*{.x} + (1 | subject_id)"))) %>%
    future_map(~ extract_interaction_lme(.x)) %>%
    bind_rows()

interaction_models <- bind_rows(
    interaction_by_sex %>% mutate(interaction = "sex"),
    interaction_by_time %>% mutate(interaction = "followup_visit_number"),
    interaction_by_sex_time %>%
        mutate(interaction = "sex and followup_visit_number")
    ) %>%
    select(interaction, outcome, predictor, term, estimate, std.error,
           conf.low, conf.high, p.value)

# Save interaction results
save(interaction_models, file = "datasets/interaction_models.rda")
