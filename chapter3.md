---
title: 'Statistical methods for cohort data'
description: 'Apply statistical techniques on cohort data.'
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
xp: 50
```

Because the Framingham study is a prospective cohort, with certain limits to the data, and with three data collection visits, there are restrictions to the types of questions we can ask and reliably answer. Choose the most valid and most appropriate question that we could ask of Framingham data.

The `tidied_framingham` dataset has been loaded in case you want to look through it.

`@possible_answers`
- Does higher cholesterol cause cardiovascular disease (CVD)?
- Will lower body mass during adolescence increase the risk for CVD?
- Does smoking increase the risk for CVD?
- Does having many close friends lower the risk for CVD?
- All of the above.

`@hint`
- Remember, these are questions to ask *of the Framingham study*... the variables in the question must exist in the dataset.
- We cannot directly determine "causes" from cohort studies.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
```

`@sct`
```{r}
msg1 <- "Incorrect. The cohort study was not designed to answer 'causes'."
msg2 <- "Incorrect. While cohorts could answer this question, Framingham participants are all in middle age so we can't answer questions outside of that timeframe."
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

Let's practice using `glmer` and seeing what it outputs. There are several things you need to consider and be aware of when running `glmer` models. This is were your knowledge of transforming variables comes into use, since the numerical value of the predictors can make a big impact on whether the model works or not.

Most of these exercises will lead to either warnings or errors, which are due to what the predictor's values are. Because running `glmer` can be computational expensive, the Framingham dataset has been reduced in size and is found in the `sample_tidied_framingham` dataset.

`@pre_exercise_code`
```{r}
# load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
load("datasets/tidied_framingham.rda")
library(lme4)
```

***

```yaml
type: NormalExercise
key: e5bd052e2a
xp: 35
```

`@instructions`
- Take a quick look at the sampled dataset. Then run the model with total cholesterol and subject ID as the random variable. Don't forget to set the family as binomial. You'll get a warning.

`@hint`
- The formula should look like `got_cvd ~ total_cholesterol + (1 | subject_id)`.

`@sample_code`
```{r}
# Have a quick look at the sampled data
summary(___)

# Run a basic, unadjusted model
glmer(got_cvd ~ ___ + (1 | ___), 
      data = sample_tidied_framingham, family = ___) 
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
success_msg("Great! Let's try to fix this.")
```

***

```yaml
type: NormalExercise
key: 182639f25f
xp: 35
```

`@instructions`
- Models try to calculate predictors with zero, but it may not make sense biologically. Take a look at the mean centered total cholesterol and use that in the model instead. You'll still get a warning.

`@hint`
 - The model formula should be `got_cvd ~ centered_total_cholesterol + (1 | subject_id)`.

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
success_msg("Amazing job! But still a problem.")
```

***

```yaml
type: NormalExercise
xp: 30
```

`@instructions`
- Often the number size is a problem. Use the `I()` function to divide centered cholesterol by 100. Check what happens. Keeping all else the same in the formula, wrap centered cholesterol with the `I()`.

`@hint`
- The formula should be `got_cvd ~ I(centered_total_cholesterol / 100) + (1 | subject_id)`.

`@sample_code`
```{r}
# Check centered cholesterol after dividing it
summary(I(___ / 100))

# Run with centered variable, divided by 100 with I()
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
success_msg("Amazing! You've solved the warnings about non-convergence and the rescaling issue.")
```

---

## Including time and comparing to logistic regression

```yaml
type: NormalExercise
xp: 100
```

Before the development of mixed effects modelling, analyzing longitudinal data was fairly difficult because repeated measures violated the assumption of independent observations (rows). This time component is a key strength of longitudinal data. But to use that strength you need to, well, including time in the model!

Include followup visit number in the `glmer` formula as well as the random term and the choleterol predictor (as in the previous exercise). Then run the same model with logistic regression (without the random term of course) and compare the results with the mixed effect model. Pay attention to the differences in the estimates and standard errors.

`@instructions`
- Run a `glmer` analysis using the same formula as the previous exercise (with the `I()` around cholesterol), but include followup visit number.
- Do the same thing with the logistic regression in `glm()` (without the random term).
- Compare the results of each model.

`@hint`
- The `glmer` formula should be `got_cvd ~ I(centered_total_cholesterol / 100) + followup_visit_number + (1 | subject_id)`.

`@pre_exercise_code`
```{r}
# load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
load("datasets/tidied_framingham.rda")
library(lme4)
```

`@sample_code`
```{r}
# Include followup visit number
glmer_model <- glmer(
    ___ ~ ___ + ___ +
        (___),
    data = sample_tidied_framingham, family = ___
    )
summary(___)

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
success_msg("Awesome! Notice how the estimate for total choleterol is the same between mixed effect and logistic models, but the standard error is very different? The estimate is biased in the logistic regression, so is smaller than it should be because it is assuming all the data come from different people, which is not true.")
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

## MCQ: Understanding confounding pathways

```yaml
type: MultipleChoiceExercise
key: e2e756d56e
xp: 50
```

{{Have this exercise before video? }}


- MCQ/text: Present a DAG of hypothesized variables and pathways. Which of the
following (or write out which) are the important variables to consider/adjust for.

- Options: {{likely all answers will be correct.. or maybe rank them ...}}
    - Since sex influences testosterone and since both sex and testosterone
    are confounders, only need to adjust for either of these variables to control
    for the confounding pathway.
    - Adjust for both 
    - Add others {{finish}}
    
Using the pathway below, which variables, at a minimum, should you adjust for to
control maximally for potential bias in the model?

- Options:
    - All of them {{possible}}
    - Only sex {{posible}}
    - Only testosterone
    - Only exercise type
    - Either sex and testosterone or sex and exercise type {{possible}}
    
Consider the below graph. Which variables, at a minimum, should you adjust for?

- Options:
    - All of them
    - Only sex {{possible}}
    - Only testosterone
    - Only exercise type
    - Either sex and testosterone or sex and exercise type or exercise and
    testosterone. {{definite}}

`@possible_answers`


`@hint`


`@pre_exercise_code`
```{r}

```

`@sct`
```{r}

```

---

## Model selection using DAGs

```yaml
type: NormalExercise
xp: 100
key: 74eb8858a3
```

Building an appropriate DAG that reasonably close to the underlying biology is very very difficult. It requires domain specific knowledge, and experts in the mechanisms and biology of the research area should be consulted as you build the DAG. As stated in the video, you are guaranteed to build an incomplete DAG. That's why you take a few approaches to model selection. 

Let's find which variables to adjust for when blood pressure (BP) is the exposure and CVD is the outcome. Keeping things simple, assume that: sex influences BP and smoking; smoking influences BP and CVD; BMI influences CVD,  BP, and FastingGlucose; and, FastingGlucose influences CVD. Create a `dagitty`  model to find out possible variables to adjust for.

`@instructions`
- Convert the above links between variables into a DAG format, in the form `variable -> {one or more variables}`. Recall that `->` means "influences" or "effects".
- Visually inspect the plot of the `variables_pathway` graph.
- Identify which variables to potentially adjust for from the `variable_pathways` graph, selecting the exposure and the outcome 'nodes'.

`@hint`


`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(dagitty)
```

`@sample_code`
```{r}
variable_pathways <- dagitty("dag {
    SBP -> CVD
    ___ -> {___ ___}
}")

# Plot potential confounding pathways
plot(graphLayout(___))

# Identify potential confounders
adjustmentSets(___, exposure = ___, outcome = ___)
```

`@solution`
```{r}
variable_pathways <- dagitty( "dag {
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

It's best to use multiple methods to decide on which variables to include in a model. The information criterion methods are powerful tools in your toolbox for  identifying and choosing the variables to control for. Using the functions from the MuMIn package shown in the video, determine which model has the best fit of the models being compared. For the purposes of this exercise, we will only use the baseline data from the Framingham dataset (through `filter()`).

`@instructions`
- Select systolic blood pressure, body mass index, sex, education, current smoking status, fasting blood glucose, and total cholesterol.
- Using the model formula, set the outcome variable in the `glm` model, as well as the dataset and family (the outcome is binary, so use logistic regression).
- "Dredge" through the combinations of variables in the model using the AIC technique, comparing models that have systolic blood pressure.
- Print the top 4 models.

`@hint`
- Use the formula interface `got_cvd ~ .`.
- Subset by systolic blood pressure.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(MuMIn)
library(dplyr)
```

`@sample_code`
```{r}
# Select the predictors from the baseline data
model_sel_df <- tidier_framingham %>% 
    filter(followup_visit_number == 1) %>% 
    select(got_cvd, ___) %>% 
    # Need to remove all NA values.
    na.omit()

# Set the outcome, data, and family
model <- glm(___ ~ ., data = ___,
             family = ___, na.action = "na.fail")

# Set the ranking method and subset
selection <- dredge(___, rank = ___, subset = ___)

# Print the top 4
head(___, 4)
```

`@solution`
```{r}
# TODO: Put this wrangling into pre-exercise chunk?
# Select the predictors from the baseline data
model_sel_df <- tidier_framingham %>% 
    filter(followup_visit_number == 1) %>% 
    select(got_cvd, systolic_blood_pressure, body_mass_index, sex, education,
           currently_smokes, fasting_blood_glucose, total_cholesterol) %>% 
    # Need to remove all NA values.
    na.omit()

# Set the outcome, data, and family
model <- glm(got_cvd ~ ., data = model_sel_df,
             family = binomial, na.action = "na.fail")

# Set the ranking method and subset
selection <- dredge(model, rank = "AIC", subset = "systolic_blood_pressure")

# Print the top 4
head(selection, 4)
```

`@sct`
```{r}
success_msg("Great job! You've identified the model that has the best fit (of those compared). Now, using the knowledge you've gained from the DAG and the AIC suggestions, you can make a more informed decision on which variables to adjust for!")
```


---

## V3 Interaction testing and sensitivity analyses

```yaml
type: VideoExercise
key: b78a1c5f22
xp: 50
```

`@projector_key`
db8d5c421cb76b9e5a85f8e22cd5dcb0

---

## CE Identifying strongly influential variables

```yaml
type: NormalExercise
key: 5fd9e209dc
xp: 100
```

Often when creating statistical models to analyze a cohort dataset, there are some
confounders that strongly change the estimate of the primary exposure with the outcome.
But building models is often done in larger steps (i.e. adding multiple covariates
at a time). For understanding the underlying relationships between variables, 
it can be useful to identify which exact variable (or variables) most strongly 
change the estimate. This is one example of a sensitivity analysis.

So identify which variable is influencing the estimates the most:


`@instructions`


`@hint`


`@pre_exercise_code`
```{r}

```

`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```

---

## CE Removing observations that strongly influence model

```yaml
type: NormalExercise
key: 591d29108e
xp: 100
```

While some variables can strongly influence the results, there are often specific
observations that can do the same. This is much more tricky to identify, since 
generally you need to visualize the results to see what observations could 
change the results and why that may be.

So, visualize the relationship with these variables and remove those observations
from the model. How do the two model results compare?



`@instructions`


`@hint`


`@pre_exercise_code`
```{r}

```

`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```

---

## CE Testing for interactions of important variables

```yaml
type: NormalExercise
key: fe5694d9fc
xp: 100
```

In the past (and still fairly common now), most research was done only on males.
Clinical trials, experimental animal models, and observational studies tended 
to either explicitly only study males, or to disregard the role that biological
sex had on the object of study. This had disasterous results, especially when it
came to drugs. In clinical trials, a drug appeared to work amazingly and was
passed for public use {{wording}}. Afterward, with observational studies tracking
the impact of drugs in the population, often times the drug would not work at all
or have harmful side effects in women. As a result, most journals and funding 
agencies *require* that sex and ethnicity be tested or studied.

Compare models without and with interactions for sex.


`@instructions`


`@hint`


`@pre_exercise_code`
```{r}

```

`@sample_code`
```{r}

```

`@solution`
```{r}
no_interaction <- lmer(prevchd ~ totchol + period + (1 | randid), data = framingham)
summary(no_interaction)

sex_interaction <- lmer(prevchd ~ totchol * sex + period + (1 | randid), data = framingham)
summary(sex_interaction)

sex_time_interaction <- lmer(prevchd ~ totchol * sex * period + (1 | randid), data = framingham)
summary(sex_time_interaction)

# TODO: confirm if ethnicity is in framingham

```

`@sct`
```{r}

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

We've created several models investigating the association between the exposure and outcome. Now we need to tidy up the model results and extract what we need from the model. Since most modelling methods don't use a consistent framework to present their results, we need to use the broom package provide that framework in a "tidy" format. 

A model has been created for you already, now you need to tidy it up. 

`@instructions`
- Using the functions from broom, tidy the model to check how the output looks.
- Then tidy it again, but adding the confidence intervals.
- Select only the most important results: the terms, the estimates, and the lower and upper confidence interval.

`@hint`
- Use the `tidy` function, with the `conf.int` argument.
- Keep only the four columns from the tidied model.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(lme4)
library(broom)
library(dplyr)
ids <- unique(tidier_framingham$subject_id)
sampled_ids <- sample(ids, length(ids) / 4, replace = FALSE)
tidier_framingham <- tidier_framingham %>% 
    filter(subject_id %in% sampled_ids)
main_model <- glmer(got_cvd ~ I(systolic_blood_pressure/10) + followup_visit_number + 
                   (1 | subject_id), 
              data = tidier_framingham, family = binomial, na.action = "na.omit")
```

`@sample_code`
```{r}
# The mixed effect model
main_model

# Tidy it up
___(___)

# Tidy but with confidence interval
tidy_model <- ___(___, ___)

# Select only the important variables
tidy_model %>% 
    ___(___)
```

`@solution`
```{r}
# The mixed effect model
main_model

# Tidy it up
tidy(main_model)

# Tidy but with confidence interval
tidy_model <- tidy(main_model, conf.int = TRUE)

# Select only the important variables
tidy_model %>% 
    select(term, estimate, conf.low, conf.high)
```

`@sct`
```{r}
success_msg("Amazing! You extracted and started tidying up the model results. Plus you now kept the most important results from the model!")
```

---

## CE Post-processing of model results

```yaml
type: NormalExercise
key: b4486ed7d2
xp: 100
```

{{NE: to show post log transforming}}

Exponentiate from tidy?

- NE: Change variables scaling or transform them to see how the estimates change...
what does that mean for interpretation? (or lesson 4)


`@instructions`


`@hint`


`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(lme4)
library(broom)
library(dplyr)
ids <- unique(tidier_framingham$subject_id)
sampled_ids <- sample(ids, length(ids) / 4, replace = FALSE)
tidier_framingham <- tidier_framingham %>% 
    filter(subject_id %in% sampled_ids)
model <- glmer(got_cvd ~ I(systolic_blood_pressure/10) + followup_visit_number + 
                   (1 | subject_id), 
              data = tidier_framingham, family = binomial, na.action = "na.omit")
```

`@sample_code`
```{r}

```

`@solution`
```{r}
model %>% 
    tidy(conf.int = TRUE) %>% 
    select(term, estimate, conf.low, conf.high) %>% 
    mutate_at(vars(-term), exp) 
```

`@sct`
```{r}

```

---

## "Not statistically significant"

```yaml
type: MultipleChoiceExercise
xp: 50
```

This is a hypothetical example based on a real study: Premature babies often face severe health problems and need lots of help to ensure healthy growth. Nutrition is key and there are many infant formula and intravenous fluids designed for premature babies. A study found that babies fed a new formula had an odds ratio of 1.12 (0.94 to 1.30 95% CI, p=0.09) for reaching a healthier weight compared to currently used formula. Which is the more correct response?

`@possible_answers`
- No significant association was seen (p>0.05, CI passes through 1.0).
- There was a small, but maybe clinically important improvement in weight (CI reached 1.30). More research is needed.
- There is a higher odds of reaching healthy weight. Let's use this new formula right away.
- Can't really say anything yet... null hypothesis was not rejected.
- None of the above.

`@hint`

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
```

`@sct`
```{r}
msg1 <- "Incorrect. While traditional p-value thresholds would say this is correct, this has the danger of discarding a new formula that could help premature babies."
msg2 <- "Correct! While 'not statistically significant', there is evidence of some potential improvement for premature babies, which needs to be further explored."
msg3 <- "Incorrect. This is too hasty a response. More studies are needed."
msg4 <- "Slightly true. It is correct to say this, but the focus should be on the uncertainty of the odds ratio, rather than the null hypothesis."
msg5 <- "Incorrect. One of the above is the more correct response."
test_mc(2, feedback_msgs = c(msg1, msg2, msg3, msg4, msg5))
```

---

## Iterative exercise

```yaml
type: BulletExercise
key: 84d96a58a8
xp: 100
```



`@pre_exercise_code`
```{r}

```

***

```yaml
type: NormalExercise
key: e5bd052e2a
xp: 50
```

`@instructions`


`@hint`


`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```

***

```yaml
type: NormalExercise
key: 182639f25f
xp: 50
```

`@instructions`


`@hint`


`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```
