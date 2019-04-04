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
- Use `summary(tidied_framingham)` to see the minimum and maximum ages of the participants.

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
ex() %>% check_mc(2, feedback_msgs = c(msg1, msg2, msg3, msg4))
```

---

## Get familiar with mixed effects models

```yaml
type: BulletExercise
key: 84d96a58a8
xp: 100
```

Let's get you familiar with using and running `glmer()` models. There is some tweaking involved when running `glmer()` models, such as transforming variables before hand. Often this requires some trial and error to get right. For now, practice running some models.

The `lme4` package has been loaded for you. Since `glmer()` is computationally expensive, the Framingham dataset has been reduced in size and is loaded as `sample_tidied_framingham`.

Recall that the pattern for using `glmer()` is:

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
- Run a model looking at how `total_cholesterol_scaled` relates to the outcome `got_cvd` (have `subject_id` as the random term).

`@hint`
- The formula should be `got_cvd ~ total_cholesterol_scaled + (1 | subject_id)`.

`@sample_code`
```{r}
# Model scaled cholesterol on CVD
model <- glmer(
    ___ ~ ___ + ___,
    data = ___,
  	# Use distribution for binary outcome
    family = ___
    )

# View the model output
summary(model)
```

`@solution`
```{r}
# Model scaled cholesterol on CVD
model <- glmer(
    got_cvd ~ total_cholesterol_scaled + (1 | subject_id),
    data = sample_tidied_framingham,
  	# Use distribution for binary outcome
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
- Try another predictor. Run a model with `fasting_blood_glucose_scaled` as a predictor instead of cholesterol.

`@hint`
- Using the same formula as the previous step, replace `total_cholesterol_scaled` with `fasting_blood_glucose_scaled`.

`@sample_code`
```{r}
# Model scaled fasting blood glucose on CVD
model <- glmer(
    ___ ~ ___ + ___,
    data = ___,
  	# Use distribution for binary outcome
    family = ___
    )

# View the model output
summary(model)
```

`@solution`
```{r}
# Model scaled fasting blood glucose on CVD
model <- glmer(
    got_cvd ~ fasting_blood_glucose_scaled + (1 | subject_id), 
    data = sample_tidied_framingham,
  	# Use distribution for binary outcome
    family = binomial
	) 

# View the model output
summary(model)
```

`@sct`
```{r}
success_msg("Great job! You've become a bit more familiar with coding and running mixed effects models in R. You ran two models to get practice on setting predictors and the formula. Now we can get to more complicated modeling aspects.")
```

---

## Why transforming may be required

```yaml
type: BulletExercise
key: 7d5ac3e0d5
xp: 100
```

You need to consider many things with `glmer()` models, e.g. large variable variances. Often `glmer()` will warn you of a problem, which you must fix using your knowledge of transformations. Getting it right often involves trial and error.

These exercises will (likely) generate warnings or errors. Compare the different transformations and notice why problems occur. Recall that we are using a smaller dataset, `sample_tidied_framingham`. The general template for `glmer()` is:

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
- As before, run a model but use `total_cholesterol` instead (`got_cvd` as the outcome); you will get a warning.

`@hint`
- Don't forget the random term: `(1 | subject_id)`.

`@sample_code`
```{r}
# Model total cholesterol on CVD
model <- glmer(
    ___ ~ ___ + (1 | ___),
    data = sample_tidied_framingham, 
    family = binomial
    )

# View the model output
summary(model)
```

`@solution`
```{r}
# Model total cholesterol on CVD
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
- Now use `total_cholesterol_centered` in the model; you will get a warning.

`@hint`
- Replace the original cholesterol variable with `total_cholesterol_centered` in the formula.

`@sample_code`
```{r}
# Model with centered cholesterol on CVD
model <- glmer(
    got_cvd ~ ___ + (1 | subject_id), 
    data = sample_tidied_framingham, 
    family = binomial
) 

# View the model output
summary(model)
```

`@solution`
```{r}
# Model with centered cholesterol on CVD
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
- Use the `total_cholesterol_scaled` variable instead; the warning should now be fixed.

`@hint`
- Include `total_cholesterol_scaled` in the formula.

`@sample_code`
```{r}
# Model with scaled cholesterol
model <- glmer(
    got_cvd ~ ___ + (1 | subject_id),
    data = sample_tidied_framingham, 
    family = binomial
) 

# View the model output
summary(model)
```

`@solution`
```{r}
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
success_msg("Amazing! You've solved the warnings about non-convergence and rescaling issue! Often it requires some trial and error to find which transformations are optimal for the model technique.")
```

---

## Include time in the mixed effect model

```yaml
type: NormalExercise
key: 0635f94add
xp: 100
```

Before the development of mixed effects modeling, analyzing longitudinal data was fairly difficult because repeated measures violated the assumption of independent observations. This time component is a key strength of longitudinal studies like with prospective cohorts. But to use that strength you need to, well, include time in the model!

Include an additional predictor (`followup_visit_number`) in the `glmer()` formula. Recall that `got_cvd` is the outcome and `subject_id` is the random term.

`@instructions`
- Run a model with two predictors: `total_cholesterol_scaled` and `followup_visit_number`.

`@hint`
- The formula should be `total_cholesterol_scaled + followup_visit_number`.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/71ac52af33d8d93192739c0ddfa3367967b42258/sample_tidied_framingham.rda"))
library(lme4)
```

`@sample_code`
```{r}
# Include followup visit number with cholesterol
model <- glmer(
  	# Add scaled cholesterol and visit
    got_cvd ~ ___ + ___ + (1 | subject_id),
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
  	# Add scaled cholesterol and visit
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

Building a DAG that approximates the biology is difficult. It requires domain knowledge, so consult experts to confirm the DAG. Remember, you will build an incomplete DAG. This is but one step to finding confounders.

Let's determine which variables to adjust for when systolic blood pressure (`SBP`) is the exposure and `CVD` is the outcome. Assume that: 

- `Sex` influences `SBP` and `Smoking`
- `Smoking` influences `SBP` and `CVD`
- `BMI` influences `CVD`,  `SBP`, and `FastingGlucose`
- `FastingGlucose` influences `CVD`

Create a `dagitty()` object to identify what to adjust for.

Recall that for `dagitty`: `x -> y` means "x influences y" and that `x -> {y z}` means "x influences y and z"; `dagitty` is already loaded.

Learn more about graphs and networks in the [Network Analysis in R](https://www.datacamp.com/courses/network-analysis-in-r) course.

`@pre_exercise_code`
```{r}
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
- Visually inspect the plot of the `variable_pathway` graph.

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
    ___ -> ___}")

# Plot potential confounding pathways
plot(graphLayout(variable_pathways))
```

`@solution`
```{r}
# Include the links between variables
variable_pathways <- dagitty("dag {
    SBP -> CVD
    Sex -> {SBP Smoking}
    Smoking -> {SBP CVD}
    BMI -> {SBP CVD FastingGlucose}
    FastingGlucose -> CVD}")

# Plot potential confounding pathways
plot(graphLayout(variable_pathways))
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
- Identify the (minimal) model `adjustmentSets()` of variables from the `variable_pathways` graph, selecting `"SBP"` as exposure and `"CVD"` as outcome.

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
    FastingGlucose -> CVD}")

# Plot potential confounding pathways
plot(graphLayout(variable_pathways))

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
    FastingGlucose -> CVD}")

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
According to the output of the `adjustmentSets()`, what variables does DAG suggest you adjust for in the model to get less biased results?

`@possible_answers`
- Sex and FastingGlucose
- [BMI and Smoking]
- Smoking, Sex, BMI
- All variables
- No variables

`@hint`
- Run the `adjustmentSets()` function again.

`@sct`
```{r}
success_msg("Amazing! You identified that at least BMI and smoking should be adjusted for by including them in the model.")
```

---

## Model selection using Information Criterion

```yaml
type: TabExercise
key: 12f92a5b3e
xp: 100
```

It's best to use multiple methods to decide on which variables to include in a model. The information criterion methods are powerful tools for choosing variables to adjust for. Using the functions from the `MuMIn` package, determine which model has the best fit for the models being compared by using AIC to rank them. A *smaller* AIC is better.

As many models will be computed and compared, for *DataCamp lesson purposes only*, we kept computing time short by: greatly reducing the sample size and number of variables in the data, called `model_sel_df`; and, setting `nAQG = 0` (reduces estimation precision, but increases speed). `MuMIn` also requires `na.action = "na.fail"` to be set in `glmer()`.

`@pre_exercise_code`
```{r}
model_sel_df <- readRDS(url("https://assets.datacamp.com/production/repositories/2079/datasets/1db99d25c4b0ca4deb2a5790d87e18ed64e2ef63/model_sel_df.Rds"))
library(MuMIn)
library(lme4)
```

***

```yaml
type: NormalExercise
key: d9e78451a2
xp: 35
```

`@instructions`
- Add `systolic_blood_pressure_scaled`, `sex`, `body_mass_index_scaled`, `currently_smokes`, and `followup_visit_number` to the formula.

`@hint`
- Model formulas are in the form: `got_cvd ~ predictor1 + predictor2 + (1 | subject_id)`.

`@sample_code`
```{r}
# Set the model formula
model <- glmer(
    got_cvd ~ ___ + ___ +
        ___ + ___ + ___ + (1 | subject_id),
    data = model_sel_df, 
    family = binomial,
    na.action = "na.fail",
 	# Speeds up computation, reduces precision
  	nAGQ = 0 
)
```

`@solution`
```{r}
# Set the model formula
model <- glmer(
    got_cvd ~ systolic_blood_pressure_scaled + body_mass_index_scaled +
        currently_smokes + sex + followup_visit_number + (1 | subject_id),
    data = model_sel_df, 
    family = binomial,
    na.action = "na.fail",
 	# Speeds up computation, reduces precision
  	nAGQ = 0 
)
```

`@sct`
```{r}
success_msg("Great job!")
```

***

```yaml
type: NormalExercise
key: 1255cd823d
xp: 35
```

`@instructions`
- `dredge()` through the combinations of variables, subset by `systolic_blood_pressure_scaled` in the model and rank by `"AIC"`.
- Print the top 3 `selection` models.

`@hint`
- Give `model` as the first argument to `dredge()`.
- Both `rank` and `subset` should be a character string.

`@sample_code`
```{r}
model <- glmer(
    got_cvd ~ systolic_blood_pressure_scaled + body_mass_index_scaled +
        currently_smokes + sex + followup_visit_number + (1 | subject_id),
    data = model_sel_df, 
    family = binomial, 
    na.action = "na.fail",
  	nAGQ = 0
)

# Set the ranking method and subset
selection <- dredge(___, rank = ___, subset = ___)

# Print the top 3
head(as.data.frame(selection), 3)
```

`@solution`
```{r}
model <- glmer(
    got_cvd ~ systolic_blood_pressure_scaled + body_mass_index_scaled +
        currently_smokes + sex + followup_visit_number + (1 | subject_id),
    data = model_sel_df, 
    family = binomial,
    na.action = "na.fail",
  	nAGQ = 0
)

# Set the ranking method and subset
selection <- dredge(model, rank = "AIC", subset = "systolic_blood_pressure_scaled")

# Print the top 3
head(as.data.frame(selection), 3)
```

`@sct`
```{r}
success_msg("Great job!")
```

***

```yaml
type: MultipleChoiceExercise
key: d9c9cb4d09
xp: 30
```

`@question`
Based on the output of `dredge()`, what variables are adjusted for in the top model?

`@possible_answers`
- BMI and smoking
- Sex and smoking
- [Sex and BMI]
- All of the variables

`@hint`
- Check which variables have missingness in the rows `selection`.

`@sct`
```{r}
success_msg("Great job! You've identified the model that has the best fit (of those compared) and which variables provide that best fit. Now, using the knowledge you've gained from the DAG and the AIC suggestions, you can make a more informed decision on which variables to adjust for!")
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

In the past (and still very common today), most research was done with mostly or entirely males. Clinical trials, experimental animal models, and observational studies tended to explicitly study males, as female hormonal cycles can act as a confounding factor. This often had harmful consequences, since there are massive gender differences in responses to drug treatment and other disease interventions. Most journals and funding agencies now *require* that differences in sex, and ethnicity, are investigated.

Since the Framingham study has almost entirely individuals of European-ancestry, we can only test sex interactions. Compare models without and with interactions for sex.

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
- Run `glmer()` models with `total_cholesterol_scaled`, `sex`, and `followup_visit_number`, without an interaction term.

`@hint`
- The predictors should be added together like `predictor1 + predictor2`.

`@sample_code`
```{r}
# Model without interaction
model_no_interaction <- glmer(
    got_cvd ~ ___ + ___ + ___ + (1 | subject_id), 
    data = sample_tidied_framingham, 
  	family = binomial)
summary(model_no_interaction)
```

`@solution`
```{r}
# Model without interaction
model_no_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, 
  	family = binomial)
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
- Create the same formula, but this time with an interaction, denoted by `*`, between `total_cholesterol_scaled` and `sex`.

`@hint`
- The interaction should be `total_cholesterol_scaled * sex`.

`@sample_code`
```{r}
# Model without interaction
model_no_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham,
  	family = binomial)

# Model with sex interaction
model_sex_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled ___ sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, 
  	family = binomial)
summary(model_sex_interaction)
```

`@solution`
```{r}
# Model without interaction
model_no_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, 
  	family = binomial)

# Model with sex interaction
model_sex_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled * sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, 
  	family = binomial)
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
- Include both model objects in `model.sel()`, with an `"AIC"` rank.

`@hint`
- Include both models, `model_no_interaction` and `model_sex_interaction`, in the `model.sel()` function, separated by a comma.

`@sample_code`
```{r}
# Model without interaction
model_no_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, 
    family = binomial)

# Model with sex interaction
model_sex_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled * sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, 
    family = binomial)

# Test if interaction adds to model
model.sel(___, ___, rank = ___)
```

`@solution`
```{r}
# Model without interaction
model_no_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham,
  	family = binomial)

# Model with sex interaction
model_sex_interaction <- glmer(
    got_cvd ~ total_cholesterol_scaled * sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham,
  	family = binomial)

# Test if interaction adds to model
model.sel(model_no_interaction, model_sex_interaction, rank = "AIC")
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: MultipleChoiceExercise
key: b0bf4c6e91
```

`@question`
Does including a cholesterol by sex interaction provide more information for the model?

`@possible_answers`
- Yes, but only by a bit.
- [No, since the models are not different.]
- No, but we should still add a sex interaction.
- None of the above.

`@hint`
- Check which model has a higher `weight` or lower `AIC`.

`@sct`
```{r}
success_msg("Wonderful! You've checked and confirmed that sex doesn't seem to influence the results. You don't need to include the interaction or report any differences since it doesn't provide additional information in the model, so better to keep the model simpler.")
```

---

## Running sensitivity analyses with body mass index

```yaml
type: TabExercise
key: b3558d44ca
xp: 100
```

Often times we make assumptions about our data and the participants that make up that data. For instance, with body mass index (BMI), we assume that the value represents a person regardless of how sick or healthy they are. However, usually if someone's BMI is really low (below around 18.5, which is considered underweight) or really high (above 40 which is considered morbidly obese), this could indicate a serious health problem that they may have. For example, people who are very ill usually lose a lot of weight. So if we include them in the model, we might get a biased estimate for the association of BMI on CVD. Run a sensitivity analysis removing these observations and compare the results.

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
- Keep those people with `body_mass_index` equal to or above 18.5 and equal to or below 40.

`@hint`
- Include two conditions (`>=` and `<=`) to restrict the range of `body_mass_index`, separated by a comma.

`@sample_code`
```{r}
# Remove low and high body masses
bmi_check_data <- sample_tidied_framingham %>% 
    filter(___ >= ___, ___ <= ___)
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
- Include `body_mass_index_scaled` and `followup_visit_number` in the formula and run the model with the `sample_tidied_framingham`.

`@hint`
- Use `sample_tidied_framingham` in the data argument.

`@sample_code`
```{r}
bmi_check_data <- sample_tidied_framingham %>% 
    filter(body_mass_index >= 18.5, body_mass_index <= 40)

# Run and check model with original dataset
original_model <- glmer(
    got_cvd ~ ___ + ___ + (1 | subject_id),
    data = ___, family = binomial)

# Fix effect estimates
fixef(original_model)
```

`@solution`
```{r}
bmi_check_data <- sample_tidied_framingham %>% 
    filter(body_mass_index >= 18.5, body_mass_index <= 40)

# Run and check model with original dataset
original_model <- glmer(
    got_cvd ~ body_mass_index_scaled + followup_visit_number + (1 | subject_id),
    data = sample_tidied_framingham, family = binomial)

# Fix effect estimates
fixef(original_model)
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
- Now run the model with the data that excludes the body mass index values.

`@hint`
- Run the same model but use the newly created `bmi_check_data`.

`@sample_code`
```{r}
bmi_check_data <- sample_tidied_framingham %>% 
    filter(body_mass_index >= 18.5, body_mass_index <= 40)

original_model <- glmer(
    got_cvd ~ body_mass_index_scaled + followup_visit_number + (1 | subject_id),
    data = sample_tidied_framingham, family = binomial)

# Run and check model with the body mass checking
bmi_check_model <- glmer(
    got_cvd ~ body_mass_index_scaled + followup_visit_number + (1 | subject_id),
    data = ___, family = binomial)

# Fix effect estimates
fixef(original_model)
fixef(bmi_check_model)
```

`@solution`
```{r}
bmi_check_data <- sample_tidied_framingham %>% 
    filter(body_mass_index >= 18.5, body_mass_index <= 40)

original_model <- glmer(
    got_cvd ~ body_mass_index_scaled + followup_visit_number + (1 | subject_id),
    data = sample_tidied_framingham, family = binomial)

# Run and check model with the body mass checking
bmi_check_model <- glmer(
    got_cvd ~ body_mass_index_scaled + followup_visit_number + (1 | subject_id),
    data = bmi_check_data, family = binomial)

# Fix effect estimates
fixef(original_model)
fixef(bmi_check_model)
```

`@sct`
```{r}
success_msg("Amazing!")
```

***

```yaml
type: MultipleChoiceExercise
key: 1948e0d9ab
```

`@question`
Look at the fixed effects estimates between each model, how do they differ?

`@possible_answers`
- The estimates for followup visit changes a lot.
- [The estimates for body mass index decreases a bit.]
- There is no difference between model estimates for any variable.
- All of the above.
- None of the above.

`@hint`


`@sct`
```{r}
success_msg("Great! The fixed effect estimates for body mass index decrease, while for followup number the values barely change. The change for the body mass index is not much but it does tell us that including people below or above a certain body mass may bias the estimates by inflating them.")
```

---

## Tidying and interpreting model results

```yaml
type: VideoExercise
key: 35c15ac891
xp: 50
```

`@projector_key`
dfd73cee12b1663ba86738a4ec9a6c06

---

## Tidy up with broom and interpret the results

```yaml
type: TabExercise
key: 33b5b785cf
xp: 100
```

Now that you've created several models, you need to do some tidying, adding confidence intervals, and transforming. Tidying mixed effects models requires the `broom.mixed` package. You'll also need to transform the estimates by exponentiating, since the model uses a binary outcome. Exponentiating converts the estimates from log-odds to odds ratios.

A model has been created for you already called `main_model`.

`@pre_exercise_code`
```{r}
main_model <- readRDS(url("https://assets.datacamp.com/production/repositories/2079/datasets/ef96cbfc9ab3b3728b18de9fa59f9600d8894add/main_model.Rds"))
library(dplyr)
options(digits = 3, scipen = 4)
```

***

```yaml
type: NormalExercise
key: aa6db67866
xp: 50
```

`@instructions`
- Use the `tidy()` function on the `main_model` object and set `conf.int` and `exponentiate` to `TRUE`.

`@hint`
- Place `main_model` as the first argument.

`@sample_code`
```{r}
library(broom.mixed)

# Tidy up main_model, include conf.int and exponentiate
tidy_model <- ___(___, conf.int = ___, exponentiate = ___)

# View the tidied model
tidy_model
```

`@solution`
```{r}
library(broom.mixed)

# Tidy up main_model, include conf.int and exponentiate
tidy_model <- tidy(main_model, conf.int = TRUE, exponentiate = TRUE)

# View the tidied model
tidy_model
```

`@sct`
```{r}
success_msg("Amazing!")
```

***

```yaml
type: NormalExercise
key: 4e07620171
xp: 50
```

`@instructions`
- `select()` only the most important results: `effect`, `terms`, `estimates`, `conf.low`, and `conf.high`.

`@hint`
- Use the `select()` function as you have done in previous exercises.

`@sample_code`
```{r}
library(broom.mixed)

tidy_model <- tidy(main_model, conf.int = TRUE, exponentiate = TRUE)

# Select the important variables
relevant_results <- tidy_model %>% 
    select(___, ___, ___, ___, ___) 

# View the relevent results
relevant_results
```

`@solution`
```{r}
library(broom.mixed)

tidy_model <- tidy(main_model, conf.int = TRUE, exponentiate = TRUE)

# Select the important variables
relevant_results <- tidy_model %>% 
    select(effect, term, estimate, conf.low, conf.high) 

# View the relevent results
relevant_results
```

`@sct`
```{r}
success_msg("Amazing! You tidied up the model and extracted the most important results!")
```

---

## Interpreting the tidied results

```yaml
type: MultipleChoiceExercise
key: cdb2dd92be
xp: 50
```

You've now created a tidied model output and kept the most relevant results. Now time to interpret! Which of the responses below is the *most* accurate interpretation of the results? 

The `relevant_results` model has been loaded for you to look over. Note that SD means standard deviation, CI means confidence interval, and CVD means cardiovascular disease.

`@possible_answers`
- 1 SD higher cholesterol has 1.1 times more CVD risk, but uncertain (0.5 to 2.8 CI).
- [1 SD higher cholesterol has 1.1 times more CVD risk (ranges 0.5 to 2.8 times), adjusted for time.]
- No significant relationships exist: CI passes 1.
- Cholesterol's relation to CVD is uncertain. Need more research.

`@hint`
- There are several that are right, but only one is the **most** accurate statement.

`@pre_exercise_code`
```{r}
main_model <- readRDS(url("https://assets.datacamp.com/production/repositories/2079/datasets/ef96cbfc9ab3b3728b18de9fa59f9600d8894add/main_model.Rds"))
library(dplyr)
library(broom.mixed)
options(digits = 3, scipen = 4)
relevant_results <- tidy(main_model, conf.int = TRUE, exponentiate = TRUE) %>% 
    select(effect, term, estimate, conf.low, conf.high) 
```

`@sct`
```{r}
msg1 <- "Nearly correct, but missing a key component of the model."
msg2 <- "Correct! You interpret the estimate and uncertainty around the estimate in the context of what you adjust for."
msg3 <- "Incorrect. An arbitrary threshold does not mean there are no relationships between variables."
msg4 <- "Nearly correct. The estimate is highly uncertain, but there is better, more accurate statement here."
ex() %>% check_mc(2, feedback_msgs = c(msg1, msg2, msg3, msg4))
```
