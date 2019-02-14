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
- Does higher cholesterol cause cardiovascular disease (CVD)?
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
msg1 <- "Incorrect. The cohort study was not designed to answer 'causes'."
msg2 <- "Incorrect. While cohorts could answer this question, Framingham participants are all in middle age so we can't answer questions outside of that time frame."
msg3 <- "Correct! The Framingham dataset collected information on smoking status and can assess relative risk between exposure status."
msg4 <- "Incorrect. While cohorts could answer this question, the Framingham Study did not collect this information."
msg5 <- "Incorrect. One of the above is a valid question."
ex() %>% check_mc(3, feedback_msgs = c(msg1, msg2, msg3, msg4, msg5))
```

---

## Get familiar with mixed effects models

```yaml
type: BulletExercise
key: 84d96a58a8
xp: 100
```

There are several things you need to consider and be aware of when running `glmer` models. For instance, large variable variances can cause computational issues. This is where your knowledge of transforming variables comes into use, as the predictors' values can effect model performance. This can involve some tweaking to transform the values so the model runs.

These exercises will likely result in warnings or errors, due to the predictor's values. The Framingham dataset has been reduced in size, since `glmer` is computationally expensive, and is loaded as `sample_tidied_framingham`.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/f64eb1d4240436aae2c7a829b93d7466c8ab1278/tidied_framingham.rda"))
library(lme4)
```

***

```yaml
type: NormalExercise
key: e5bd052e2a
xp: 35
```

`@instructions`
- Look over the sampled data, then add cholesterol as a $x$, subject ID as the random term, and use a binomial family.

`@hint`
- The random term goes in the `(1 | ___)` portion of code.

`@sample_code`
```{r}
# Have a quick look at the sampled data
summary(___)

# Run a basic, unadjusted model
model <- glmer(got_cvd ~ ___ + (1 | ___), 
      data = sample_tidied_framingham, family = ___) 

# View the model output
summary(___)
```

`@solution`
```{r}
# Have a quick look at the sampled data
summary(sample_tidied_framingham)

# Run a basic, unadjusted model
model <- glmer(got_cvd ~ total_cholesterol + (1 | subject_id), 
      data = sample_tidied_framingham, family = binomial) 

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
key: 182639f25f
xp: 35
```

`@instructions`
- Let's fix the warning by mean-centering cholesterol in the model.

`@hint`
- The mean centered cholesterol variable is found already in the dataset.

`@sample_code`
```{r}
# Take a look at centered cholesterol
summary(sample_tidied_framingham$___)

# Run with centered variable
model <- glmer(___ ~ ___ + (___), 
      data = sample_tidied_framingham, family = ___) 

# View the model output
___
```

`@solution`
```{r}
# Take a look at centered cholesterol
summary(sample_tidied_framingham$centered_total_cholesterol)

# Run with centered variable
model <- glmer(got_cvd ~ centered_total_cholesterol + (1 | subject_id), 
      data = sample_tidied_framingham, family = binomial) 

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
key: f5444213d6
xp: 30
```

`@instructions`
- There's still a warning about rescaling, as the variance is too large, so use `I()` and divide cholesterol by 100.

`@hint`
- Use the same formula as in the previous exercises, but wrap the cholesterol variable with the `I()` function.

`@sample_code`
```{r}
# Check centered cholesterol after dividing it
summary(I(___ / 100))

# Wrap centered cholesterol with I()
model <- glmer(
    ___ ~ ___,
    data = sample_tidied_framingham, family = ___
    )

# View the model output
___
```

`@solution`
```{r}
# Check centered cholesterol after dividing it
summary(I(sample_tidied_framingham$centered_total_cholesterol / 100))

# Run with centered variable, divided by 100 with I()
model <- glmer(
    got_cvd ~ I(centered_total_cholesterol / 100) + (1 | subject_id),
    data = sample_tidied_framingham, family = binomial
    )

# View the model output
summary(model)
```

`@sct`
```{r}
success_msg("Amazing! You've solved the warnings about non-convergence, large eigenvalues, and the rescaling issue.")
```

---

## Include time and compare to logistic regression

```yaml
type: TabExercise
key: ee91386423
xp: 100
```

Before the development of mixed effects modeling, analyzing longitudinal data was fairly difficult because repeated measures violated the assumption of independent observations. This time component is a key strength of longitudinal data. But to use that strength you need to, well, include time in the model!

Include followup visit number in the `glmer` formula as well as the random term and the cholesterol predictor (as in the previous exercise with `I()`). Then run the same model with logistic regression (without the random term of course) and compare the results with the mixed effect model. Pay attention to the differences in the estimates and standard errors.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/f64eb1d4240436aae2c7a829b93d7466c8ab1278/tidied_framingham.rda"))
library(lme4)
```

***

```yaml
type: NormalExercise
key: 6324cefad8
xp: 50
```

`@instructions`
- Run a `glmer` analysis using the same formula as the previous exercise (with the `I()` around cholesterol), but also include followup visit number.

`@hint`
- The formula is the exact same as the previous exercise, except there is an additional predictor.

`@sample_code`
```{r}
# Include followup visit number
glmer_model <- glmer(
    ___ ~ ___ + ___ +
        (___),
    data = sample_tidied_framingham, family = ___
    )
summary(___)
```

`@solution`
```{r}
# Include followup visit number
glmer_model <- glmer(
    got_cvd ~ I(centered_total_cholesterol / 100) + followup_visit_number +
        (1 | subject_id),
    data = sample_tidied_framingham, family = binomial
    )
summary(glmer_model)
```

`@sct`
```{r}
success_msg("Great! Next step.")
```

***

```yaml
type: NormalExercise
key: a50714fbc4
xp: 50
```

`@instructions`
- Do the same thing with the logistic regression in `glm()` (without the random term), paying attention to the differences in results.

`@hint`
- Use the exact same formula as in the `glmer` function, except the random term `(1 | ___)`.

`@sample_code`
```{r}
# Include followup visit number
glmer_model <- glmer(
    got_cvd ~ I(centered_total_cholesterol / 100) + followup_visit_number +
        (1 | subject_id),
    data = sample_tidied_framingham, family = binomial
    )
summary(glmer_model)

# Compare with logistic regression
glm_model <- glm(
    ___ ~ ___ + ___,
    data = sample_tidied_framingham, family = ___)
summary(___)
```

`@solution`
```{r}
# Include followup visit number
glmer_model <- glmer(
    got_cvd ~ I(centered_total_cholesterol / 100) + followup_visit_number +
        (1 | subject_id),
    data = sample_tidied_framingham, family = binomial
    )
summary(glmer_model)

# Compare with logistic regression
glm_model <- glm(
    got_cvd ~ I(centered_total_cholesterol / 100) + followup_visit_number,
    data = sample_tidied_framingham, family = binomial)
summary(glm_model)
```

`@sct`
```{r}
success_msg("Awesome! Notice how the estimate for total cholesterol is the same between mixed effect and logistic models, but the standard error is very different? The estimate is biased in the logistic regression, so the error is smaller because it is assuming all the data come from different people, which is not true.")
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
type: NormalExercise
key: 74eb8858a3
xp: 100
```

Building an appropriate DAG that is reasonably close to the underlying biology is very very difficult. It requires domain specific knowledge, consult experts familiar with the mechanisms and biology as you build the DAG. As stated in the video, you are guaranteed to build an incomplete DAG. That's why you take a few approaches to model selection. 

Let's find which variables to adjust for when systolic blood pressure (SBP) is the exposure and CVD is the outcome. Keeping things simple, assume that: sex influences SBP and smoking; smoking influences SBP and CVD; BMI influences CVD,  SBP, and FastingGlucose; and, FastingGlucose influences CVD. Create a `dagitty`  model to find out adjustment sets.

`@instructions`
- Convert the above links between variables into a DAG, in the form `variable -> {one or more variables}` (remember, `->` means "influences" or "effects").
- Visually inspect the plot of the `variables_pathway` graph.
- Identify which variables to potentially adjust for from the `variable_pathways` graph, specifying the exposure and the outcome variables.

`@hint`
- The `adjustmentSets()` requires the DAG object and the outcome (CVD) and the predictor (SBP).

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/f64eb1d4240436aae2c7a829b93d7466c8ab1278/tidied_framingham.rda"))
library(dagitty)
```

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

# Plot potential confounding pathways
plot(graphLayout(___))

# Identify potential confounders
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

# Identify potential confounders
adjustmentSets(variable_pathways, exposure = "SBP", outcome = "CVD")
```

`@sct`
```{r}
success_msg("Amazing! You identified that at least BMI and smoking should be adjusted for.")
```

---

## Model selection using Information Criterion

```yaml
type: NormalExercise
key: dc6191ab98
xp: 100
```

It's best to use multiple methods to decide on which variables to include in a model. The information criterion methods are powerful tools in your toolbox for identifying and choosing the variables to adjust for. Using the functions from the MuMIn package, determine which model has the best fit for the models being compared. 

To keep the computation run time quick, for this exercise we will use logistic regression rather than mixed effects models. Therefore, we will only use the baseline data from the Framingham dataset (through `filter()`) to fit the model assumptions.

`@instructions`
- Select the centered variables systolic blood pressure, body mass index, fasting blood glucose, and total cholesterol, as well as sex, education, and current smoking status. 
- Set the outcome in the `glm` formula, the dataset, and the family (the outcome is binary).
- "Dredge" through the combinations of variables in the model using AIC, comparing models that have centered systolic blood pressure.
- Print the top 4 models.

`@hint`
- Use the formula interface `got_cvd ~ .`.
- Subset by centered systolic blood pressure.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/f64eb1d4240436aae2c7a829b93d7466c8ab1278/tidied_framingham.rda"))
library(MuMIn)
library(dplyr)
```

`@sample_code`
```{r}
# Select the predictors from the baseline data
model_sel_df <- tidied_framingham %>% 
    filter(followup_visit_number == 1) %>% 
    select(got_cvd, ___) %>% 
    na.omit()

# Set the outcome, data, and family
model <- glm(___ ~ ., data = ___, family = ___, na.action = "na.fail")

# Set the ranking method and subset
selection <- dredge(___, rank = ___, subset = ___)

# Print the top 4
head(___, 4)
```

`@solution`
```{r}
# Select the predictors from the baseline data
model_sel_df <- tidied_framingham %>% 
    filter(followup_visit_number == 1) %>% 
    select(got_cvd, centered_systolic_blood_pressure, sex, education, centered_body_mass_index, 
           currently_smokes, centered_total_cholesterol, centered_fasting_blood_glucose) %>% 
    na.omit()

# Set the outcome, data, and family
model <- glm(got_cvd ~ ., data = model_sel_df, family = binomial, na.action = "na.fail")

# Set the ranking method and subset
selection <- dredge(model, rank = "AIC", subset = "centered_systolic_blood_pressure")

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

In the past (and still fairly common), most research was done only on males. Clinical trials, experimental animal models, and observational studies tended  to either explicitly only study males, or to disregard the role that biological sex had on the study. This had disasterous results, especially when it came to drugs. Now, most journals and funding agencies *require* that differences in sex and ethnicity are investigated or tested.

The Framingham study was almost entirely those of European-ancestry, so we will only test sex interactions. Compare models without and with interactions for sex.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/f64eb1d4240436aae2c7a829b93d7466c8ab1278/tidied_framingham.rda"))
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
- Run `glmer` models with centered total cholesterol (divided by 100), sex, followup visit, and the random term, but no interaction.

`@hint`
- Use the `I()` to divide centered cholesterol by 100.

`@sample_code`
```{r}
# Model without interaction
no_interaction <- glmer(
    ___ ~ ___ + ___ + ___ + (___), 
    data = sample_tidied_framingham, family = ___)
summary(___)
```

`@solution`
```{r}

# Model without interaction
no_interaction <- glmer(
    got_cvd ~ I(centered_total_cholesterol / 100) + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(no_interaction)
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
- Create the same formula, but this time with an interaction between sex and cholesterol.

`@hint`
- The variables to check for an interaction should be around the `*` in the formula.

`@sample_code`
```{r}
# Model without interaction
no_interaction <- glmer(
    got_cvd ~ I(centered_total_cholesterol / 100) + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(no_interaction)

# Model with sex interaction
sex_interaction <- glmer(
    ___ ~ ___ * ___ + (___), 
    data = sample_tidied_framingham, family = ___)
summary(___)
```

`@solution`
```{r}
# Model without interaction
no_interaction <- glmer(
    got_cvd ~ I(centered_total_cholesterol / 100) + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(no_interaction)

# Model with sex interaction
sex_interaction <- glmer(
    got_cvd ~ I(centered_total_cholesterol / 100) * sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(sex_interaction)
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
- Compare each using the `model.sel` function based on AIC.

`@hint`
- Include both models, with and without interaction, in the `model.sel` function.

`@sample_code`
```{r}
# Model without interaction
no_interaction <- glmer(
    got_cvd ~ I(centered_total_cholesterol / 100) + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(no_interaction)

# Model with sex interaction
sex_interaction <- glmer(
    got_cvd ~ I(centered_total_cholesterol / 100) * sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(sex_interaction)

# Test that sex doesn't add to model
model.sel(___, ___, rank = ___)

```

`@solution`
```{r}
# Model without interaction
no_interaction <- glmer(
    got_cvd ~ I(centered_total_cholesterol / 100) + sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(no_interaction)

# Model with sex interaction
sex_interaction <- glmer(
    got_cvd ~ I(centered_total_cholesterol / 100) * sex + followup_visit_number + (1 | subject_id), 
    data = sample_tidied_framingham, family = binomial)
summary(sex_interaction)

# Test that sex doesn't add to model
model.sel(no_interaction, sex_interaction, rank = "AIC")

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

Often times we make assumptions about our data and the participants that make up that data. For instance, with body mass index (BMI), we assume that the value represents a person regardless of how sick or healthy they are. However, usually if someone's BMI is really low (below around 18.5) or really high (for instance, above 45), this could indicate a serious health problem that they have. For example, people who are very ill usually lose a lot of weight. So if we include them in the model, we might get a biased estimate for the association of BMI on CVD. Run a sensitivity analysis removing these observations and compare the results.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/f64eb1d4240436aae2c7a829b93d7466c8ab1278/tidied_framingham.rda"))
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
- Filter out those people with body mass index (not centered) below 18.5 and above 45.

`@hint`
- The argument order of `between` is variable, lower range, upper range.

`@sample_code`
```{r}
# Remove low and high body masses
bmi_check_data <- sample_tidied_framingham %>% 
    filter(between(___, ___, ___))
```

`@solution`
```{r}
# Remove low and high body masses
bmi_check_data <- sample_tidied_framingham %>% 
    filter(between(body_mass_index, 18.5, 45))
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
- Including centered body mass index, followup visit, and the random term in the formula, run the model with the original dataset.

`@hint`
- The model formula is the same as the previous exercises, but using the original dataset.

`@sample_code`
```{r}
# Remove low and high body masses
bmi_check_data <- sample_tidied_framingham %>% 
    filter(between(body_mass_index, 18.5, 45))

# Run and check model with original dataset
original_model <- glmer(___ ~ ___ + ___ + (___),
                        data = ___, family = binomial)
summary(___)$coef
```

`@solution`
```{r}
# Remove low and high body masses
bmi_check_data <- sample_tidied_framingham %>% 
    filter(between(body_mass_index, 18.5, 45))

# Run and check model with original dataset
original_model <- glmer(got_cvd ~ centered_body_mass_index + followup_visit_number + (1 | subject_id),
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
    filter(between(body_mass_index, 18.5, 45))

# Run and check model with original dataset
original_model <- glmer(got_cvd ~ centered_body_mass_index + followup_visit_number + (1 | subject_id),
                        data = sample_tidied_framingham, family = binomial)
summary(original_model)$coef

# Run and check model with the body mass checking
bmi_check_model <- glmer(___ ~ ___ + ___ + (___),
                        data = ___, family = binomial)
___(___)$___
```

`@solution`
```{r}
# Remove low and high body masses
bmi_check_data <- sample_tidied_framingham %>% 
    filter(between(body_mass_index, 18.5, 45))

# Run and check model with original dataset
original_model <- glmer(got_cvd ~ centered_body_mass_index + followup_visit_number + (1 | subject_id),
                        data = sample_tidied_framingham, family = binomial)
summary(original_model)$coef

# Run and check model with the body mass checking
bmi_check_model <- glmer(got_cvd ~ centered_body_mass_index + followup_visit_number + (1 | subject_id),
                        data = bmi_check_data, family = binomial)
summary(bmi_check_model)$coef
```

`@sct`
```{r}
success_msg("Amazing! Notice how the estimate increases and the standard error decreases. However, the change is not much, so it tells us there may be differences in those below or above a certain BMI. But we need to explore it more.")

```

---

## Tidying and extracting results from model objects

```yaml
type: VideoExercise
key: 35c15ac891
xp: 50
```

`@projector_key`
dfd73cee12b1663ba86738a4ec9a6c06

---

## Tidy up the results with broom

```yaml
type: NormalExercise
key: 6c2f7f04d3
xp: 100
```

We've created several models investigating the association between the exposure and outcome. Now we need to tidy up the model results and extract what we need from the model. Since most modelling methods don't use a consistent framework to present their results, we need to use the broom package to provide that framework in a "tidy" format. 

A model has been created for you already, now you need to tidy it up.

`@instructions`
- Using the functions from broom, tidy the model to check how the output looks.
- Then tidy it again, but adding the confidence intervals.
- Select only the most important results: the terms, the estimates, and the lower and upper confidence interval.
- Exponentiate (`exp`) by mutating all but the terms.

`@hint`
- Use the `tidy` function, with the `conf.int` argument.
- Keep only the four columns from the tidied model.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/f64eb1d4240436aae2c7a829b93d7466c8ab1278/tidied_framingham.rda"))
library(lme4)
library(broom)
library(dplyr)
main_model <- glmer(got_cvd ~ I(centered_total_cholesterol/100) + followup_visit_number + 
                   (1 | subject_id), 
              data = sample_tidied_framingham, family = binomial, na.action = "na.omit")
```

`@sample_code`
```{r}
# Check mixed effect model
main_model

# Tidy it up
___(___)

# Tidy but with confidence interval
tidy_model <- ___(___, ___)

# Select only the important variables and exponentiate
tidy_model %>% 
    ___(___) %>% 
    ___(vars(-term), ___)
```

`@solution`
```{r}
# Check mixed effect model
main_model

# Tidy it up
tidy(main_model)

# Tidy but with confidence interval
tidy_model <- tidy(main_model, conf.int = TRUE)

# Select only the important variables and exponentiate
tidy_model %>% 
    select(term, estimate, conf.low, conf.high) %>% 
    mutate_at(vars(-term), exp)
```

`@sct`
```{r}
success_msg("Amazing! You extracted and started tidying up the model results. Plus you now kept the most important results from the model!")
```

---

## "Not statistically significant"

```yaml
type: MultipleChoiceExercise
key: 9eee53c6f6
xp: 50
```

This is a hypothetical example based on a real study: Premature babies often face severe health problems and need lots of help to ensure healthy growth. Nutrition is key and there are many infant formula and intravenous fluids designed for premature babies. A study found that babies fed a new formula had an odds ratio of 1.12 (0.94 to 1.30 95% CI, p=0.09) for reaching a healthier weight compared to currently used formula. Which is the more correct response?

`@possible_answers`
- No significant association (p>0.05, CI passes through 1.0).
- The small weight improvement could be meaningful (CI reached 1.30). More research is needed.
- There is a higher odds of improving weight. Let's use this formula right away.
- Can't say anything yet... null hypothesis was not rejected.

`@hint`
- The upper bound of the confidence interval reaches an odds ratio of 1.30.

`@pre_exercise_code`
```{r}
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/f64eb1d4240436aae2c7a829b93d7466c8ab1278/tidied_framingham.rda"))
```

`@sct`
```{r}
msg1 <- "Incorrect. While traditional p-value thresholds would say this is correct, this has the danger of discarding a new formula that could help premature babies."
msg2 <- "Correct! While 'not statistically significant', there is evidence of some potential improvement for premature babies, which needs to be further explored."
msg3 <- "Incorrect. This is too hasty a response. More studies are needed."
msg4 <- "Slightly true. It is correct to say this, but the focus should be on the uncertainty of the odds ratio, rather than the null hypothesis."
ex() %>% check_mc(2, feedback_msgs = c(msg1, msg2, msg3, msg4))
```
