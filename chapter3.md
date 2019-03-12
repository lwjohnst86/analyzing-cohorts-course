---
title: 'Statistical methods for cohort data'
description: 'There are a wide range of statistical techniques you could apply to cohort datasets, and they depend heavily on the study design, research questions, and the type of data collected. In this chapter we will focus more on how to approach choosing the statistical method, what to think about, types of tests to use, and how to extract the revelant results from any statistical model.'
---

## Statistical analyses for cohort studies

```yaml
type: VideoExercise
key: bf6ca16325
xp: 50
```

`@projector_key`
5ab6b9af44fc27034571fab5f10ca3ef

---

## What questions can be asked from Framingham?

```yaml
type: MultipleChoiceExercise
key: 846ad549f8
xp: 50
```

Because the Framingham study is a prospective cohort, with certain limits to the data and with three data collection visits, there are restrictions to the types of questions we can ask and reliably answer. Choose the most valid and most appropriate question that we could ask of the Framingham data.

The `tidied_framingham` dataset is loaded. Before answering, look at the variables available in the dataset, and the age range of the participants.

`@possible_answers`
- Will lower body mass during adolescence increase the risk for CVD?
- Does smoking increase the risk for CVD?
- Does having many close friends lower the risk for CVD?
- All of the above.

`@hint`
- Remember, these are questions to ask *of the Framingham study*. The variables in the question must exist in the dataset.
- Use `glimpse(tidied_framingham)` to see which variables are available.
- Use `range(tidied_framingham$participant_age)` to see the ages of the participants.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/f64eb1d4240436aae2c7a829b93d7466c8ab1278/tidied_framingham.rda"))
library(dplyr)
```

`@sct`
```{r}
msg1 <- "Incorrect. While cohorts could answer this question, Framingham participants are all in middle age so we can't answer questions outside of that time frame."
msg2 <- "Correct! The Framingham dataset collected information on smoking status and can assess relative risk between exposure status."
msg3 <- "Incorrect. While cohorts could answer this question, the Framingham Study did not collect this information."
msg4 <- "Incorrect. One of the above is a valid question."
ex() %>% check_mc(3, feedback_msgs = c(msg1, msg2, msg3, msg4))
```

---

## Get familiar with mixed effects models

```yaml
type: BulletExercise
key: 84d96a58a8
xp: 100
```

Let's get you familiar with using and running `glmer` models. There is some tweaking involved when running `glmer` models, such as transforming variables before hand. Often this requires some trial and error to get right. For now, practice running some models.

Since `glmer` is computationally expensive, the Framingham dataset has been reduced in size and is loaded as `sample_tidied_framingham`.

Recall that the pattern for using `glmer` is:

```{r}
model <- glmer(
    outcome_var ~ predictor_var + (1 | person_id),
    data = dataset,
    family = binomial
)
```

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/71ac52af33d8d93192739c0ddfa3367967b42258/sample_tidied_framingham.rda"))
library(lme4)
```

***

```yaml
type: NormalExercise
key: ad97101e99
xp: 50
```

`@instructions`
- Run a model looking at how cholesterol (scaled) relates to CVD (have subject ID as the random term).

`@hint`
- The variables should be `got_cvd`, `total_cholesterol_scaled`, and `subject_id`.

`@sample_code`
```{r}
# Confirm name of predictor
names(___)

# Model cholesterol on CVD
model <- glmer(
    ___ ~ ___,
    data = ___,
    family = ___
    )

# View the model output
summary(___)
```

`@solution`
```{r}
# Confirm name of predictor
names(sample_tidied_framingham)

# Model centered cholesterol on CVD
model <- glmer(
    got_cvd ~ total_cholesterol_scaled + (1 | subject_id),
    data = sample_tidied_framingham, 
    family = binomial
    )

# View the model output
summary(model)
```

`@sct`
```{r}
success_msg("Amazing!")
```

***

```yaml
type: NormalExercise
key: d3065312e7
xp: 50
```

`@instructions`
- Try another predictor. Run a model using fasting blood glucose (scaled) as a predictor instead of cholesterol.

`@hint`
- The variable is `fasting_blood_glucose_scaled`.

`@sample_code`
```{r}
# Confirm name of predictor
names(___)

# Model fasting blood glucose on CVD
model <- glmer(
    ___ ~ ___,
    data = ___,
    family = ___
    )

# View the model output
summary(___)
```

`@solution`
```{r}
# Confirm name of predictor
names(sample_tidied_framingham)

# Model fasting blood glucose on CVD
model <- glmer(
    got_cvd ~ fasting_blood_glucose_scaled + (1 | subject_id), 
    data = sample_tidied_framingham, 
    family = binomial
) 

# View the model output
summary(model)
```

`@sct`
```{r}
success_msg("Great job! You've ran several mixed effects models!")
```

---

## Why transforming may be required

```yaml
type: BulletExercise
key: 7d5ac3e0d5
xp: 100
```

There are several things you need to consider when running `glmer` models, as they can be finnicky. For instance, large variable variances can cause computational issues in the model. Often `glmer` will throw an error or warning telling you of the problem.

To fix the problem, your knowledge of transformations comes into use. Getting the right transformation can sometimes involve trial and error to get the model to run.

These exercises will (likely) generate warnings or errors. Compare the different transformations and notice why problems may occur. 

Recall that the dataset is smaller and is loaded as `sample_tidied_framingham`, as well as what the general pattern is for `glmer`:

```{r}
model <- glmer(
    outcome_var ~ predictor_var + (1 | person_id),
    data = dataset,
    family = binomial
)
```

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/71ac52af33d8d93192739c0ddfa3367967b42258/sample_tidied_framingham.rda"))
library(lme4)
```

***

```yaml
type: NormalExercise
key: 19eebe2393
xp: 35
```

`@instructions`
- Plot the original total cholesterol and include it in the model; you will get a warning.

`@hint`
- Don't forget the random term: `(1 | subject_id)`.

`@sample_code`
```{r}
# Plot of original cholesterol
plot(sample_tidied_framingham$___)

# Model the total cholesterol
model <- glmer(
    ___ ~ ___,
    data = sample_tidied_framingham, 
    family = binomial
    )

# View the model output
summary(model)
```

`@solution`
```{r}
# Plot of original cholesterol
plot(sample_tidied_framingham$total_cholesterol)

# Model the total cholesterol
model <- glmer(
    got_cvd ~ total_cholesterol + (1 | subject_id),
    data = sample_tidied_framingham, 
    family = binomial
    )

# View the model output
summary(model)
```

`@sct`
```{r}
success_msg("Amazing job!")
```

***

```yaml
type: NormalExercise
key: ddddfcd2f8
xp: 35
```

`@instructions`
- Compare centered cholesterol and use it in the model.

`@hint`
- Use `names(sample_tidied_framingham)` to get the correct name of the cholesterol predictor.

`@sample_code`
```{r}
# Compare the original vs centered variable
plot(sample_tidied_framingham$total_cholesterol)
plot(sample_tidied_framingham$___)

# Model with centered cholesterol
model <- glmer(
    ___,
    data = sample_tidied_framingham, 
    family = binomial
) 

# View the model output
summary(model)
```

`@solution`
```{r}
# Compare the original vs centered variable
plot(sample_tidied_framingham$total_cholesterol)
plot(sample_tidied_framingham$total_cholesterol_centered)

# Model with centered cholesterol
model <- glmer(
    got_cvd ~ total_cholesterol_centered + (1 | subject_id), 
    data = sample_tidied_framingham, 
    family = binomial
) 

# View the model output
summary(model)
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: NormalExercise
key: 105d4c6ea5
xp: 30
```

`@instructions`
- Lastly, we can fix the warnings by using the scaled cholesterol variable.

`@hint`
- The variable is `total_cholesterol_scaled`.

`@sample_code`
```{r}
# Compare the original vs centered vs scaled variables
plot(sample_tidied_framingham$total_cholesterol)
plot(sample_tidied_framingham$total_cholesterol_centered)
plot(sample_tidied_framingham$___)

# Model with scaled cholesterol
model <- glmer(
    ___,
    data = sample_tidied_framingham, 
    family = binomial
) 

# View the model output
summary(model)
```

`@solution`
```{r}
# Compare the original vs centered vs scaled variables
plot(sample_tidied_framingham$total_cholesterol)
plot(sample_tidied_framingham$total_cholesterol_centered)
plot(sample_tidied_framingham$total_cholesterol_scaled)

# Model with scaled cholesterol
model <- glmer(
    got_cvd ~ total_cholesterol_scaled + (1 | subject_id),
    data = sample_tidied_framingham, 
    family = binomial
) 

# View the model output
summary(model)
```

`@sct`
```{r}
success_msg("Amazing! You've solved the warnings about non-convergence, large eigenvalues, and the rescaling issue.")
```

---

## Include time in the mixed effect model

```yaml
type: NormalExercise
key: 0635f94add
xp: 100
```

Before the development of mixed effects modeling, analyzing longitudinal data was fairly difficult because repeated measures violated the assumption of independent observations. This time component is a key strength of longitudinal data. But to use that strength you need to, well, include time in the model!

Include followup visit number in the `glmer` formula as well as the random term and the scaled choleterol predictor.

`@instructions`
- Run a model of cholesterol (scaled) and followup visit number on CVD.

`@hint`
- Include `followup_visit_number` after scaled cholesterol, still including the subject ID.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/71ac52af33d8d93192739c0ddfa3367967b42258/sample_tidied_framingham.rda"))
library(lme4)
```

`@sample_code`
```{r}
# Include followup visit number with cholesterol
model <- glmer(
    ___,
    data = sample_tidied_framingham, 
    family = binomial
    )

# View the model summary
summary(model)
```

`@solution`
```{r}
# Include followup visit number with cholesterol
model <- glmer(
    got_cvd ~ total_cholesterol_scaled + followup_visit_number + (1 | subject_id),
    data = sample_tidied_framingham, 
    family = binomial
    )

# View the model summary
summary(model)
```

`@sct`
```{r}
success_msg("Awesome! Adding a time component to any analysis that has repeated measurements is quite important. It reduces model bias and allows you to interpret the results in the context of time.")
```

---

## Adjustment, confounding, and model building

```yaml
type: VideoExercise
key: ebe9e09786
xp: 50
```

`@projector_key`
911feb6e308d8e7e180f7f33f32a51ed

---

## Model selection using DAGs

```yaml
type: TabExercise
key: 4af692e468
xp: 100
```

Building an appropriate DAG that approximates the biology is very hard. It requires domain knowledge, so consult experts familiar with the mechanisms as you build the DAG. Remember, you are guaranteed to build an incomplete DAG. That's why you take several model selection approaches. 

Let's determine which variables to adjust for when systolic blood pressure (SBP) is the exposure and CVD is the outcome. Keeping things simple, assume that: Sex influences SBP and Smoking; Smoking influences SBP and CVD; BMI influences CVD,  SBP, and FastingGlucose; and, FastingGlucose influences CVD. Create a `dagitty`  model to find out adjustment sets.

Recall that for dagitty, `x -> y` means "x influences y" and that `x -> {y z}` means
"x influences y and z".

To learn more about graphs and networks, check out the [Network Analysis in R](https://www.datacamp.com/courses/network-analysis-in-r) course.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/71ac52af33d8d93192739c0ddfa3367967b42258/sample_tidied_framingham.rda"))
library(dagitty)

variable_pathways <- dagitty("dag {
    SBP -> CVD
    Sex -> {SBP Smoking}
    Smoking -> {SBP CVD}
    BMI -> {SBP CVD FastingGlucose}
    FastingGlucose -> CVD
}")
plot(graphLayout(variable_pathways))
```

***

```yaml
type: NormalExercise
key: fc9f26a1a9
xp: 35
```

`@instructions`
- Using both the links between variables described in the context above and the plot as a guide, create a DAG of the hypothetical pathways.

`@hint`
- The form for a pathway is `start_variable -> {one or more end variables}`.

`@sample_code`
```{r}
# Include the links between variables
variable_pathways <- dagitty("dag {
    SBP -> CVD
    ___ -> {___ ___}
    ___ -> {___ ___}
    ___ -> {___ ___ ___}
    ___ -> ___
}")
```

`@solution`
```{r}
# Include the links between variables
variable_pathways <- dagitty("dag {
    SBP -> CVD
    Sex -> {SBP Smoking}
    Smoking -> {SBP CVD}
    BMI -> {SBP CVD FastingGlucose}
    FastingGlucose -> CVD
}")
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: NormalExercise
key: 1b78256dd8
xp: 35
```

`@instructions`
- Visually inspect the plot of the `variables_pathway` graph.
- Identify the (minimal) model adjustment set of variables from the `variable_pathways` graph, selecting the appropriate exposure and the outcome variables.

`@hint`
- The `adjustmentSets()` requires the DAG object and the outcome (CVD) and the predictor (SBP).

`@sample_code`
```{r}
# Include the links between variables
variable_pathways <- dagitty("dag {
    SBP -> CVD
    Sex -> {SBP Smoking}
    Smoking -> {SBP CVD}
    BMI -> {SBP CVD FastingGlucose}
    FastingGlucose -> CVD
}")

# Plot potential confounding pathways
plot(graphLayout(___))

# Identify some confounders to adjust for
adjustmentSets(___, exposure = ___, outcome = ___)
```

`@solution`
```{r}
# Include the links between variables
variable_pathways <- dagitty("dag {
    SBP -> CVD
    Sex -> {SBP Smoking}
    Smoking -> {SBP CVD}
    BMI -> {SBP CVD FastingGlucose}
    FastingGlucose -> CVD
}")

# Plot potential confounding pathways
plot(graphLayout(variable_pathways))

# Identify some confounders to adjust for
adjustmentSets(variable_pathways, exposure = "SBP", outcome = "CVD")
```

`@sct`
```{r}
success_msg("Excellent job!")
```

***

```yaml
type: MultipleChoiceExercise
key: 7198bda654
xp: 30
```

`@question`


`@possible_answers`
success_msg("Amazing! You identified that at least BMI and smoking should be adjusted for.")

`@hint`


`@sct`
```{r}

```

---

## Model selection using Information Criterion

```yaml
type: NormalExercise
key: dc6191ab98
xp: 100
```

It's best to use multiple methods to decide on which variables to include in a model. The information criterion methods are powerful tools in your toolbox for identifying and choosing the variables to adjust for. Using the functions from the MuMIn package, determine which model has the best fit for the models being compared. 

We've greatly restricted the sample size and reduced the number of variables to include in the model to keep the computation run time short.

`@instructions`
- Set CVD as the outcome and subject ID as the random term.
- Include all other remaining variables as predictors in the formula.
- "Dredge" through the combinations of variables that have systolic blood pressure (scaled) in the model using AIC to rank models.
- Print the top 4 models.

`@hint`
- Model formulas are in the form: `got_cvd ~ predictor1 + predictor2 + (1 | subject_id)`.
- Subset by `systolic_blood_pressure_scaled`.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/71ac52af33d8d93192739c0ddfa3367967b42258/sample_tidied_framingham.rda"))
library(MuMIn)
library(dplyr)
library(lme4)
# TODO: Add reduced sample code here
ids <- unique(sample_tidied_framingham$subject_id)
sampled_ids <- sample(ids, length(ids) / 3, replace = FALSE)
sample_tidied_framingham <- sample_tidied_framingham %>%
    filter(subject_id %in% sampled_ids)
model_sel_df <- sample_tidied_framingham %>% 
    # filter(followup_visit_number == 1) %>% 
    select(subject_id, got_cvd, systolic_blood_pressure_scaled, sex,
           total_cholesterol_scaled, currently_smokes, followup_visit_number) %>% 
    mutate(subject_id = as.character(subject_id)) %>% 
    na.omit()
```

`@sample_code`
```{r}
# Check column names
names(model_sel_df)

# Set the outcome, random term, data, and family
model <- glmer(
    ___,
    data = model_sel_df, 
    family = binomial, 
    na.action = "na.fail"
)

# Set the ranking method and subset
selection <- dredge(___, rank = ___, subset = ___)

# Print the top 4
head(___, 4)
```

`@solution`
```{r}
# Check column names
names(model_sel_df)

# Set the outcome, data, and family
model <- glmer(
    got_cvd ~ systolic_blood_pressure_scaled + total_cholesterol_scaled + 
        currently_smokes + sex + followup_visit_number + (1 | subject_id),
    data = model_sel_df, 
    family = binomial, 
    na.action = "na.fail"
)

# Set the ranking method and subset
selection <- dredge(model, rank = "AIC", subset = "systolic_blood_pressure_scaled")

# Print the top 4
head(selection, 4)
```

`@sct`
```{r}
success_msg("Great job! You've identified the model that has the best fit (of those compared). Now, using the knowledge you've gained from the DAG and the AIC suggestions, you can make a more informed decision on which variables to adjust for!")
```

---

## Testing for interactions and sensitivity analyses

```yaml
type: VideoExercise
key: b78a1c5f22
xp: 50
```

`@projector_key`
db8d5c421cb76b9e5a85f8e22cd5dcb0

---

## Determining sex interaction with the predictor

```yaml
type: TabExercise
key: 6ed7e200c3
xp: 100
```

In the past (and still very common today), most research was done mostly or only on males. Clinical trials, experimental animal models, and observational studies tended to explicitly study males, as female hormonal cycles can potential be a confounding factor. This often had harmful consequences, since there are massive gender differences in responses to drug treatment and other disease interventions. Most journals and funding agencies now *require* that differences in sex, and ethnicity, are investigated.

Since the Framingham study was almost entirely those of European-ancestry, we will only test sex interactions. Compare models without and with interactions for sex.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/71ac52af33d8d93192739c0ddfa3367967b42258/sample_tidied_framingham.rda"))
library(lme4)
library(MuMIn)
```

***

```yaml
type: NormalExercise
key: 7c2789a651
xp: 40
```

`@instructions`
- Run `glmer` models with total cholesterol (scaled), sex, followup visit number, and subject ID as the random term, but don't include an interaction.

`@hint`
- Confirm the names of the variables by using `names(sample_tidied_framingham)`.

`@sample_code`
```{r}
# Model without interaction
model_no_interaction <- glmer(
    ___,
    data = sample_tidied_framingham, family = binomial)
summary(model_no_interaction)
```

`@solution`
```{r}
# Model without interaction
model_no_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(model_no_interaction)
```

`@sct`
```{r}
success_msg("Great! Next step.")
```

***

```yaml
type: NormalExercise
key: 5f9ee35506
xp: 40
```

`@instructions`
- Create the same formula, but this time with an interaction between sex and total cholesterol (scaled).

`@hint`
- Use a `*` instead of a `+` for including an interaction between variables in the formula.

`@sample_code`
```{r}
# Model without interaction
model_no_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(model_no_interaction)

# Model with sex interaction
model_sex_interaction <- glmer(
    ___,
    data = sample_tidied_framingham, family = binomial)
summary(model_sex_interaction)
```

`@solution`
```{r}
# Model without interaction
model_no_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(model_no_interaction)

# Model with sex interaction
model_sex_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled * sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(model_sex_interaction)
```

`@sct`
```{r}
success_msg("Great! Next step.")
```

***

```yaml
type: NormalExercise
key: a142eaf9e5
xp: 20
```

`@instructions`
- Compare each model using the `model.sel` function based on AIC.

`@hint`
- Include both models, with and without interaction, in the `model.sel` function.

`@sample_code`
```{r}
# Model without interaction
model_no_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(model_no_interaction)

# Model with sex interaction
model_sex_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled * sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(model_sex_interaction)

# Test that sex doesn't add to model
model.sel(___, ___, rank = ___)
```

`@solution`
```{r}
# Model without interaction
model_no_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(model_no_interaction)

# Model with sex interaction
model_sex_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled * sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(model_sex_interaction)

# Test that sex doesn't add to model
model.sel(model_no_interaction, model_sex_interaction, rank = "AIC")
```

`@sct`
```{r}
success_msg("Wonderful! You've checked and confirmed that sex doesn't seem to influence the results. You don't need to include the interaction or report any differences.")
```

---

## Running sensitivity analyses with body mass index

```yaml
type: TabExercise
key: b3558d44ca
xp: 100
```

Often times we make assumptions about our data and the participants that make up that data. For instance, with body mass index (BMI), we assume that the value represents a person regardless of how sick or healthy they are. However, usually if someone's BMI is really low (below around 18.5, which is considered underweight) or really high (above 40 which is considered morbidly obese), this could indicate a serious health problem that they have. For example, people who are very ill usually lose a lot of weight. So if we include them in the model, we might get a biased estimate for the association of BMI on CVD. Run a sensitivity analysis removing these observations and compare the results.

Use the `sample_tidied_framingham` dataset.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/71ac52af33d8d93192739c0ddfa3367967b42258/sample_tidied_framingham.rda"))
library(lme4)
library(dplyr)
```

***

```yaml
type: NormalExercise
key: 18db3cb9bd
xp: 20
```

`@instructions`
- Keep those people with body mass index at or above 18.5 and at or below 40.

`@hint`
- Include two conditions (`>=` and `<=`) to restrict the range of body mass index.

`@sample_code`
```{r}
# Remove low and high body masses
bmi_check_data <- sample_tidied_framingham %>% 
    filter(___)
```

`@solution`
```{r}
# Remove low and high body masses
bmi_check_data <- sample_tidied_framingham %>% 
    filter(body_mass_index >= 18.5, body_mass_index <= 40)
```

`@sct`
```{r}
success_msg("Excellent! Next step.")
```

***

```yaml
type: NormalExercise
key: 2adddd58a9
xp: 40
```

`@instructions`
- Include body mass index (scaled), followup visit, and subject ID in the formula, then run the model with the original dataset.

`@hint`
- The model formula is the same as the previous exercises, but using the original dataset.

`@sample_code`
```{r}
# Remove low and high body masses
bmi_check_data <- sample_tidied_framingham %>% 
    filter(body_mass_index >= 18.5, body_mass_index <= 40)

# Run and check model with original dataset
original_model <- glmer(
    ___,
    data = ___, family = binomial)
summary(___)$coef
```

`@solution`
```{r}
# Remove low and high body masses
bmi_check_data <- sample_tidied_framingham %>% 
    filter(body_mass_index >= 18.5, body_mass_index <= 40)

# Run and check model with original dataset
original_model <- glmer(
    got_cvd ~ body_mass_index_scaled + followup_visit_number + (1 | subject_id),
    data = sample_tidied_framingham, family = binomial)
summary(original_model)$coef
```

`@sct`
```{r}
success_msg("Excellent! Next step.")
```

***

```yaml
type: NormalExercise
key: f9dec391b0
xp: 40
```

`@instructions`
- Now run the model with the data that excluded some BMI values, paying attention to how or if the results differ.

`@hint`
- Run the same model but use the newly created `bmi_check_data`.

`@sample_code`
```{r}
# Remove low and high body masses
bmi_check_data <- sample_tidied_framingham %>% 
    filter(body_mass_index >= 18.5, body_mass_index <= 40)

# Run and check model with original dataset
original_model <- glmer(
    got_cvd ~ body_mass_index_scaled + followup_visit_number + (1 | subject_id),
    data = sample_tidied_framingham, family = binomial)
summary(original_model)$coef

# Run and check model with the body mass checking
bmi_check_model <- glmer(
    ___,
    data = ___, family = binomial)
summary(___)$coef
```

`@solution`
```{r}
# Remove low and high body masses
bmi_check_data <- sample_tidied_framingham %>% 
    filter(body_mass_index >= 18.5, body_mass_index <= 40)

# Run and check model with original dataset
original_model <- glmer(
    got_cvd ~ body_mass_index_scaled + followup_visit_number + (1 | subject_id),
    data = sample_tidied_framingham, family = binomial)
summary(original_model)$coef

# Run and check model with the body mass checking
bmi_check_model <- glmer(
    got_cvd ~ body_mass_index_scaled + followup_visit_number + (1 | subject_id),
    data = bmi_check_data, family = binomial)
summary(bmi_check_model)$coef
```

`@sct`
```{r}
success_msg("Amazing! Notice how the fixed effect estimates for body mass index decrease and the standard error slightly increases, while for followup number the values barely change. The change for the body mass index is not much but it does tell us that including people below or above a certain body mass may bias the estimates by inflating them.")
```

---

## Predictions, interpretations, and tidying of model results

```yaml
type: VideoExercise
key: 35c15ac891
xp: 50
```

`@projector_key`
dfd73cee12b1663ba86738a4ec9a6c06

---

## Tidy up and back-transform the results with broom

```yaml
type: NormalExercise
key: 6c2f7f04d3
xp: 100
```

Now that you've created several models, you need to do some tidying and back-transforming. Since most modelling methods don't use a consistent framework to present their results, we need to use the broom package to provide that framework in a "tidy" format. Tidying mixed effects models requires the broom.mixed package. Back-transforming by exponentiating is required as the model uses a binary outcome, which give log-odds estimates that can be difficult to interpret. Exponentiating converts the estimates to odds. 

A model has been created for you already called `main_model`.

`@instructions`
- Using the functions from broom.mixed, tidy the model, create confidence intervals and exponentiate the estimates.
- Select only the most important results: the terms, the estimates, and the lower and upper confidence interval.

`@hint`
- Use the `tidy` function on model object.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/71ac52af33d8d93192739c0ddfa3367967b42258/sample_tidied_framingham.rda"))
library(lme4)
library(dplyr)
main_model <- glmer(got_cvd ~ total_cholesterol_scaled + followup_visit_number + (1 | subject_id), 
              data = sample_tidied_framingham, family = binomial, na.action = "na.omit")
options(digits = 3, scipen = 4)
```

`@sample_code`
```{r}
library(broom.mixed)

# Tidy up main_model, include conf.int and exponentiate
tidy_model <- ___

# View the tidied model
tidy_model

# Select the four important variables
tidy_model %>% 
    ___(___)
```

`@solution`
```{r}
library(broom.mixed)

# Tidy up main_model, include conf.int and exponentiate
tidy_model <- tidy(main_model, conf.int = TRUE, exponentiate = TRUE)

# View the tidied model
tidy_model

# Select the four important variables
tidy_model %>% 
    select(term, estimate, conf.low, conf.high) 
```

`@sct`
```{r}
success_msg("Amazing! You tidied up the model and have extracted the most important results!")
```
