---
title: 'Statistical methods and cohort data'
description: 'Apply statistical techniques on cohort data.'
---

## Insert exercise title here

```yaml
type: VideoExercise
key: bf6ca16325
xp: 50
```

`@projector_key`
5ab6b9af44fc27034571fab5f10ca3ef

---

## MCQ What questions can be asked from Framingham?

```yaml
type: MultipleChoiceExercise
xp: 50
key: aa53930250
```

Because the Framingham study is a prospective cohort, with certain limits to the data and with three data collection visits, there are restrictions to the types of questions we can ask and reliably answer. Choose the most valid and most appropriate question that we could ask of Framingham data.

The unchanged `framingham` dataset is loaded in case you want to look through it.

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
load(url("https://assets.datacamp.com/production/repositories/2079/datasets/8ebd3fc8dc74530ce5a24fe07bca6abf380f9e62/framingham.rda"))
framingham$time <- NULL
```

`@sct`
```{r}
msg1 <- "Incorrect. The cohort study was not designed to answer 'causes'."
msg2 <- "Incorrect. While cohorts could answer this question, Framingham participants are all in middle age so we can't answer questions outside of that timeframe."
msg3 <- "Correct! The Framingham dataset collected information on smoking status and can assess relative risk between exposure status."
msg4 <- "Incorrect. While cohorts could answer this question, the Framingham Study did not collect this information."
msg5 <- "Incorrect. One of the above is a valid question."
test_mc(3, feedback_msgs = c(msg1, msg2, msg3, msg4, msg5))
```

---

## V2: Adjustment, confounding, and models

```yaml
type: VideoExercise
key: ebe9e09786
xp: 50
```

`@projector_key`
911feb6e308d8e7e180f7f33f32a51ed

---

## Insert exercise title here

```yaml
type: MultipleChoiceExercise
key: e2e756d56e
xp: 50
```



`@possible_answers`


`@hint`


`@pre_exercise_code`
```{r}

```

`@sct`
```{r}

```

---

## CE Model selection using Information Criterion

```yaml
type: NormalExercise
key: dc6191ab98
xp: 100
```


When you are unsure of which variables may provide a better fit and maybe
explain the model and results more, using model information criterion methods
can help narrow the possible models down. For instance when deciding on
appropriate covariates to adjust for, using this technique combined with other 
techniques such as literature based or DAG based can provide more information on
what to best adjust for. Information criterion such as Akaike Information
Criterion (AIC) are used to balance good model fit with low model complexity
(i.e. less variables adjusted for). Run this command to identify which model is
the "best" of those compared.

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
# TODO: Make more appropriate models (more typically seen in real analyses).
# TODO: Confirm that MuMIn is the best package for learners to use.
# TODO: Switch over to use glmer and random effects.
library(MuMIn)
model_sel_df <- framingham %>% 
    select(cvd, totchol, sex, bmi) %>% 
    na.omit()
m1 <- glm(cvd ~ totchol, data = model_sel_df, family = binomial)
m2 <- glm(cvd ~ totchol + sex, data = model_sel_df, family = binomial)
m3 <- glm(cvd ~ totchol + sex + bmi, data = model_sel_df, family = binomial)

model.sel(m1, m2, m3)

# Which is the "best" model from these three?
"m3"
```

`@sct`
```{r}

```


---

## CE Inappropriate adjustment

```yaml
type: NormalExercise
key: c318aa084c
xp: 100
```

{{Maybe a Tab/BulletExercise}}

Run model without adjusting, with adjusting, and lastly with adjusting for an inappropriate variable (how that changes things). Notice how that may change the results. (Don't worry about what the numbers mean just yet, focus on the differences of the estimates between models.)

{{MCQ?}}
{{Given the results, what are some possible conclusions/interpretations?}}
{{How might the adjustment for age AND period influence the results?}}


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
# TODO: Confirm that period and randid are sorted properly.
# TODO: Confirm that cvd variable is the right one (from raw data).
unadjusted <- lmer(prevchd ~ totchol + period + (1 | randid), data = framingham)
summary(unadjusted)$coef

adjusted <- lmer(prevchd ~ totchol + sex + period + (1 | randid), data = framingham)
summary(adjusted)$coef

inappropriate <- lmer(prevchd ~ totchol + sex + age + period + (1 | randid), data = framingham)
summary(inappropriate)$coef
```

`@sct`
```{r}

```

---

## CE Post-processing of model results

```yaml
type: NormalExercise
key: b4486ed7d2
xp: 100
```

{{NE: to show post log transforming}}


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

## V4 Extracting results from model objects

```yaml
type: VideoExercise
key: 35c15ac891
xp: 50
```

`@projector_key`
dfd73cee12b1663ba86738a4ec9a6c06

---

## Insert exercise title here

```yaml
type: MultipleChoiceExercise
key: 3f30c7266d
xp: 50
```



`@possible_answers`


`@hint`


`@pre_exercise_code`
```{r}

```

`@sct`
```{r}

```

---

## CE Tidy up the results with broom

```yaml
type: NormalExercise
key: 6c2f7f04d3
xp: 100
```


Most methods developed into R packages in R have their own unique way of showing
the results from the models, so there is no standard way to present the output of
the models. So the broom package was created to make a unified interface
(similar to the `summary` function) of the output in a "tidy" {{link}} format.

Run these code to tidy up the output, using the `tidy` function. Extract only 
relevant
{{TODO: add another exercise expanding on this to make estimate more meaningful}}


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
# TODO: Add family. Use glmer, but fix the "non-convergence" issue.
model <- lmer(prevchd ~ totchol + period + (1 | randid), data = framingham)

# Tidy it up
tidy(model)

# Tidy but with confidence interval (CI)
tidy_model <- tidy(model, conf.int = TRUE)
tidy_model

# Select only the important variables.
tidy_model %>% 
    select(term, estimate, conf.low, conf.high)
```

`@sct`
```{r}

```

---

## TBE "Not statistically significant" 

```yaml
type: TabExercise
key: ece86a1406
xp: 100
```

...does not equal "not biologically or clinically significant"


{{MCQ; TabExercise?}}

{{This may need to be shortened and/or changed... but I want to get this point
across somehow}}

There is a very strong culture within science to focus on "statistically
significant" results, and this is no different in health research. However,
there are some major problems with this behaviour and practice not just for
science but also for health and disease outcomes.

Let's make an example: Premature babies often face severe health problems as
they grow and need substantial medical and nutritional assistance to ensure a
healthier growth. Nutrition is a key component and there are infant formula and
intravenous fluids specifically designed for premature infants. A study
observing the role of these formula on the premature babies' health found an
odds ratio of 1.12 (0.94 to 1.30 95% CI, p=0.09) of getting a health
complication from current formula for premature babies born earlier compared to
premature babies born later in gestational age. How would this be interpreted?

- There was no significant association seen (p>0.05, odds ratio passes through
the 1.0 threshold).
- There is a small, but potentially clinically important association seen (OR
had up to 1.30 in the CI).
    - {{correct. Even though it is not "statistically significant", to improve
    health outcomes in premature babies, the formula may need to change.}}
- Can't really say anything... null hypothesis was not rejected.
    - {{slightly true, but this shouldn't be focused}}
    
- MCQ/text: Which are the most appropriate interpretations for OR, RR, IRR?

{{Next MCQ}}

Great! It's really important to understand this concept in health research, and
how you present your results changes based on what you "believe" is important.
So why is this important?

- This isn't important! The p-value was larger than 0.05!
- It is important, but we can't really say anything until more research is done.
It may be that formula needs to be changed.
    - {{more correct, as we don't completely know yet and need to explore this more}}
- It is important, so let's change the feeding formulas right away to target
babies born earlier!
    - {{almost correct, but this is also too hasty}}

`@pre_exercise_code`
```{r}

```

***

```yaml
type: NormalExercise
key: 7c09b4abd6
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
type: MultipleChoiceExercise
key: 58233677a5
xp: 50
```

`@question`


`@possible_answers`


`@hint`


`@sct`
```{r}

```

---

## CE Unreliability of p-value, importance of estimate

```yaml
type: NormalExercise
key: ee505007b7
xp: 100
```

how small changes to data can influence p-value.


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
