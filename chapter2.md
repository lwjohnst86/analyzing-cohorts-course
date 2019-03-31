---
title: 'Exploring, wrangling, and transforming cohort data'
description: 'Before statistically analyzing cohort data, you''ll need to explore and wrangle it into an appropriately analyzable format. You''ll also learn about some common transformations to apply to variables in cohort studies.'
---

## Pre-wrangling exploration

```yaml
type: VideoExercise
key: f20c0dcfb8
xp: 50
```

`@projector_key`
146b85090bb8ab77efbfe45c5c751f5d

---

## Plot univariate distributions

```yaml
type: BulletExercise
key: 78574fab0c
xp: 100
```

Let's get comfortable creating some univariate histograms to start exploring the data. Create several histograms of a couple variables.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(ggplot2)
```

***

```yaml
type: NormalExercise
key: c1d2dff125
xp: 50
```

`@instructions`
- Set `x` to `participant_age` and add a `geom_histogram()` layer.

`@hint`
- In the `aes()`, the argument should be `x = participant_age`.

`@sample_code`
```{r}
# Examine the age histogram
ggplot(tidier_framingham, aes(x = ___)) +
    ___()
```

`@solution`
```{r}
# Examine the age histogram
ggplot(tidier_framingham, aes(x = participant_age)) +
    geom_histogram()
```

`@sct`
```{r}
success_msg("Nice!")
```

***

```yaml
type: NormalExercise
key: ca8520f319
xp: 50
```

`@instructions`
- Do the same thing, but set `x` to `systolic_blood_pressure`.

`@hint`
- The `aes()` should have `x = systolic_blood_pressure`.

`@sample_code`
```{r}
# Examine the systolic blood pressure histogram
ggplot(tidier_framingham, aes(x = ___)) +
    ___()
```

`@solution`
```{r}
# Examine the systolic blood pressure histogram
ggplot(tidier_framingham, aes(x = systolic_blood_pressure)) +
    geom_histogram()
```

`@sct`
```{r}
success_msg("Great job! You've created histograms and examined two variables.")
```

---

## Long data and visualizing multiple variables over time

```yaml
type: TabExercise
key: c03b3cbc95
xp: 100
```

Now that you've learned how to create histograms, let's convert some of the Framingham dataset into the longer data format using `gather()`. Then, using the long data form, create histograms for multiple variables simultaneously for each followup visit. This will give us quick overview of the data and their distribution. Pay attention to how the distribution of each variable looks like.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(dplyr)
library(tidyr)
library(ggplot2)
```

***

```yaml
type: NormalExercise
key: 871fc51832
```

`@instructions`
- Select the variables `total_cholesterol`, `high_density_lipoprotein`, and `low_density_lipoprotein`.
- Using `gather()`, set the two new column names as `variable` and `value`, and then exclude `followup_visit_number` from being "gathered" (using the `-`).

`@hint`
- The `gather()` function should look like `gather(variable, value, -followup_visit_number)`.

`@sample_code`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the three cholesterol-based variables
        ___, ___, ___
    ) %>%
    gather(___, ___, -___)
```

`@solution`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the three cholesterol-based variables
        total_cholesterol, high_density_lipoprotein, low_density_lipoprotein
    ) %>%
    gather(variable, value, -followup_visit_number)
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: NormalExercise
key: f47ff957e7
xp: 35
```

`@instructions`
- Use `facet_wrap()` by the variables `followup_visit_number` and `variable`. Don't forget about using the `vars()` function.

`@hint`
- The variables in `facet_wrap()` need to be within the `vars()` function and separated by a comma.

`@sample_code`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the three cholesterol-based variables
        total_cholesterol, high_density_lipoprotein, low_density_lipoprotein
    ) %>%
    gather(variable, value, -followup_visit_number) %>%
    ggplot(aes(x = value)) +
    geom_histogram() +
    # Facet by followup and cholesterol variables
    ___(___(___, ___), 
        scales = "free")
```

`@solution`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the three cholesterol-based variables
        total_cholesterol, high_density_lipoprotein, low_density_lipoprotein
    ) %>%
    gather(variable, value, -followup_visit_number) %>%
    ggplot(aes(x = value)) +
    geom_histogram() +
    # Facet by followup and cholesterol variables
    facet_wrap(vars(followup_visit_number, variable), 
               scales = "free")
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: NormalExercise
key: b4ebf26231
xp: 35
```

`@instructions`
- Do the same thing, but selecting the variables `participant_age`, `body_mass_index`, and `cigarettes_per_day`.

`@hint`
- Put the variables in the `select()` function.

`@sample_code`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the three charactistics
        ___, ___, ___
    ) %>%
    gather(variable, value, -followup_visit_number) %>%
    ggplot(aes(x = value)) +
    geom_histogram() +
    facet_wrap(vars(followup_visit_number, variable), 
               scales = "free")
```

`@solution`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the three charactistics
        body_mass_index, participant_age, cigarettes_per_day
    ) %>%
    gather(variable, value, -followup_visit_number) %>%
    ggplot(aes(x = value)) +
    geom_histogram() +
    facet_wrap(vars(followup_visit_number, variable), 
               scales = "free")
```

`@sct`
```{r}
success_msg("Amazing!")
```

***

```yaml
type: MultipleChoiceExercise
key: cb687dd833
xp: 30
```

`@question`
There were several things that you could see from the distributions of the variables and things to consider for later analyses. Did you notice a few of them?

Which of the answers below describes some observations about the data?

`@possible_answers`
- The lipoprotein data was not available at visits 1 and 2.
- Most people smoked zero cigarettes per day.
- The participants' age had a "jagged", uneven distribution.
- [All of the above.]
- None of the above.

`@hint`
- Run the code again and check the histogram plots.

`@sct`
```{r}
success_msg("Great job! These types of observations are important to consider and examine, as they can profoundly influence later inferential analyses.")
```

---

## Visually examine the outcomes with the exposures

```yaml
type: NormalExercise
key: e50ea375f8
xp: 100
```

Boxplots are great for showing a distribution by a grouping variable (e.g. sex or disease status). Create multiple boxplots of several exposure variables with the outcome variable (CVD) by combining what we learned previously about converting to long form and using facetting.

`@instructions`
- Select the variables `got_cvd`, `total_cholesterol`, `participant_age`, and `body_mass_index`.
- Also exclude `got_cvd` from the `gather()` function and set `value` for the y-axis in `aes()`.
- Add a `geom_boxplots()` layer, with `got_cvd` as a color in `aes()`.
- Lastly, flip the plot using `coord_flip()`.

`@hint`
- The initial `ggplot2` setup should be `ggplot(aes(x = value, y = variable, color = got_cvd))`.
- Include `-got_cvd` after `-followup_visit_number` in `gather()`.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(dplyr)
library(tidyr)
library(ggplot2)
tidier_framingham <- tidier_framingham %>% 
    mutate(got_cvd = as.character(got_cvd))
```

`@sample_code`
```{r}
tidier_framingham %>% 
    select(followup_visit_number,
           # Select the disease and the three continuous variables
           ___, ___,
           ___, ___) %>% 
    # Exclude also the disease
    gather(variable, value, -followup_visit_number, -___) %>% 
    # Set y, x, and colour
    ggplot(aes(y = ___, x = variable, color = ___)) +
    # Plot boxplots
    ___() +
    facet_wrap(vars(followup_visit_number), ncol = 1) +
    # Flip the plot
    ___()
```

`@solution`
```{r}
tidier_framingham %>% 
    select(followup_visit_number,
           # Select the disease and the three continuous variables
           got_cvd, total_cholesterol,
           participant_age, body_mass_index) %>% 
    # Exclude also the disease
    gather(variable, value, -followup_visit_number, -got_cvd) %>% 
    # Set y, x, and colour
    ggplot(aes(y = value, x = variable, color = got_cvd)) +
    # Plot boxplots
    geom_boxplot() +
    facet_wrap(vars(followup_visit_number), ncol = 1) +
    # Flip the plot
    coord_flip()
```

`@sct`
```{r}
success_msg("Excellent! You quickly created a figure showing several continuous variables by the outcome, and over time! Notice how some variables are a bit higher in the `got_cvd` group and that over time these differences decreased? Also notice the problem of showing multiple variables that have vastly different values such as between body mass and cholesterol.")
```

---

## Discrete data and tidying it for later analysis

```yaml
type: VideoExercise
key: 3d338af036
xp: 50
```

`@projector_key`
4e1f8ff56b37d8caee655cf2b0b4639d

---

## Make discrete variables human-readable

```yaml
type: BulletExercise
xp: 100
```

As you may have noticed, there are several discrete variables with ambiguous values. For instance, sex has the values as either 1 or 2, but what do those numbers mean? Often, you will encounter discrete data as integers rather than human-readable strings when working with cohort datasets. With data like this, you need to have a data dictionary to know what the numbers mean. Let's fix this problem and tidy up the data so it is human-readable.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(dplyr)
```

***

```yaml
type: NormalExercise
xp: 50
```

`@instructions`
- Convert the education values to a human readable format using `case_when()`.
- The original education numbers should correspond to the following strings: 1 = "0-11 years"; 2 = "High School"; 3 = "Vocational"; 4 = "College".

`@hint`
- The form for the `case_when()` should look like `education == 1 ~ "0-11 years"`, for each number-string pairing.

`@sample_code`
```{r}
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        # Convert the values for education
        education = ___(
            # Use the format: variable == number ~ "string"
            education == ___ ~ ___,
          	education == ___ ~ ___,
          	education == ___ ~ ___,
          	education == ___ ~ ___,
            TRUE ~ NA_character_)
      )

# Check changed education
count(tidier2_framingham, education)
```

`@solution`
```{r}
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        # Convert the values for education
        education = case_when(
            # Use the format: variable == number ~ "string"
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_)
      )

# Check changed education
count(tidier2_framingham, education)
```

`@sct`
```{r}
success_msg("Excellent!")
```

***

```yaml
type: NormalExercise
xp: 50
```

`@instructions`
- Do the same thing for the sex variable, with the numbers corresponding to the following strings: 1 = "Man"; 2 = "Woman".

`@hint`
- The form for the `case_when()` should look like `sex == 1 ~ "Man"`, for each number-string pairing.

`@sample_code`
```{r}
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        # Convert the values for sex
        sex = case_when(
          	# Use the format: variable == number ~ "string"
        	sex == ___ ~ ___,
            sex == ___ ~ ___,
            TRUE ~ NA_character_)
    )
    
# Check changed education
count(tidier2_framingham, sex)
```

`@solution`
```{r}
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        # Convert the values for sex
        sex = case_when(
          	# Use the format: variable == number ~ "string"
        	sex == ___ ~ ___,
            sex == ___ ~ ___,
            TRUE ~ NA_character_)
    )
    
# Check changed education
count(tidier2_framingham, sex)
```

`@sct`
```{r}
success_msg("Awesome! You've tidied up discrete values to be understandable to humans!")
```

---

## Merge factor categories together

```yaml
type: NormalExercise
key: 62bcf49a5e
xp: 100
```

Sometimes, categorical variables (as factors or characters) have many levels but only a few observations in one or more levels. It might make sense to combine categories together for some analyses or particular questions. This is especially useful if we only want to interpret one level compared to the other levels. 

The `forcats` package has been preloaded as well as the previous `tidier2_framingham` dataset you tidied.

`@instructions`
- Recode the levels of `"Vocational"` and `"College"` education to be `"Post-Secondary"`.
- Confirm that the education values have been correctly recoded using `count()` on the new education variable.

`@hint`
- Use the `fct_recode` function to recode the levels. 
- Use `count` on the `education_combined` variable.
- Compare how the numbers differ between the original and the new education variable over each follow-up visit.

`@pre_exercise_code`
```{r}
tidier2_framingham <- readRDS(url("https://assets.datacamp.com/production/repositories/2079/datasets/16a8a17e784e845c75eb7fe15899683684e89a22/tidier2_framingham.Rds"))
library(forcats)
library(dplyr)
tidier2_framingham$education_combined <- NULL
```

`@sample_code`
```{r}
# Merge college and vocational levels
tidier2_framingham <- tidier2_framingham %>% 
    mutate(education_combined = ___(
        education, 
        # Form is: "new" = "old"
        ___ = ___,
        ___ = ___
        ))

# Confirm changes to variable
___(tidier2_framingham, ___)

# Compare counts of original and merged by visit
___
___
```

`@solution`
```{r}
# Merge college and vocational levels
tidier2_framingham <- tidier2_framingham %>% 
    mutate(education_combined = fct_recode(
        education, 
        # Form is: "new" = "old"
        "Post-Secondary" = "College",
        "Post-Secondary" = "Vocational"
        ))

# Confirm changes to variable
count(tidier2_framingham, education_combined)

# Compare counts of original and merged by visit
count(tidier2_framingham, followup_visit_number, education)
count(tidier2_framingham, followup_visit_number, education_combined)
```

`@sct`
```{r}
success_msg("Great! You've combined two factor levels together into a new level.")
```

---

## Variable transformations

```yaml
type: VideoExercise
key: bfcfbe9aa2
xp: 50
```

`@projector_key`
5d026dadac109f3540f3c1f59a6f96ea

---

## Apply several transformations

```yaml
type: NormalExercise
key: c812627e90
xp: 100
```

There are several types of transformations you can choose from. Which one you choose depends on the question, the data values, the statistical method you use, and how you want your results to be interpreted. In later chapters we will cover how each transformation changes how you interpret the results of your analyses.

`@instructions`
- Log, square root, and invert the values of body mass index and cigarettes per day.
- Confirm that the transformed variables were created.

`@hint`
- Use the `body_mass_index` and the `cigarettes_per_day` variables.
- Use `log` and `sqrt` to transform the values.

`@pre_exercise_code`
```{r}
tidier2_framingham <- readRDS(url("https://assets.datacamp.com/production/repositories/2079/datasets/16a8a17e784e845c75eb7fe15899683684e89a22/tidier2_framingham.Rds"))
library(dplyr)
```

`@sample_code`
```{r}
invert <- function(x) 1 / x

# Use three transformations on body mass index
transformed_framingham <- tidier2_framingham %>% 
    mutate_at(vars(___, ___), 
              funs(___, ___, invert))

# Confirm created variables
summary(___)
```

`@solution`
```{r}
invert <- function(x) 1 / x

# Use three transformations on body mass index
transformed_framingham <- tidier_framingham %>% 
    mutate_at(vars(body_mass_index, cigarettes_per_day), 
              funs(log, sqrt, invert))

# Confirm created variables
summary(transformed_framingham)
```

`@sct`
```{r}
success_msg("Excellent! You've used several transformation types on two variables.")
```

---

## Compare the different transformations

```yaml
type: BulletExercise
key: a4867af13b
xp: 100
```

Visualize how each transformation influences the distribution of the data. Graphing these transformations is useful in helping to guide you to choosing a certain transformation.

We want to plot all transformation types on one plot. As we've done several times throughout the course, we need to have a long data format to do this.

`@pre_exercise_code`
```{r}
transformed_framingham <- readRDS(url("https://assets.datacamp.com/production/repositories/2079/datasets/db4b0d894d5c2a05c8eab34f0432903694b8f8ad/transformed_framingham.Rds"))
library(tidyr)
library(dplyr)
library(ggplot2)
```

***

```yaml
type: NormalExercise
key: e0ccd581d4
xp: 50
```

`@instructions`
- Convert the dataset into the long form for the body mass index variables and create a ggplot histogram.

`@hint`
- Use `gather` to convert to long form.
- Name the key argument `variables` and the value argument `values`.
- Use `geom_histogram` as a ggplot layer.
- Have `x = values` as the aesthetic.

`@sample_code`
```{r}
# Plot body mass index transforms
bmi_transforms_plot <- transformed_framingham %>% 
    ___(variables, values, contains("___")) %>% 
    ___(___(x = values)) +
    ___ +
    facet_wrap( ~ variables, scale = "free")

bmi_transforms_plot
```

`@solution`
```{r}
# Plot body mass index transforms
bmi_transforms_plot <- transformed_framingham %>% 
    gather(variables, values, contains("body_mass_index")) %>% 
    ggplot(aes(x = values)) +
    geom_histogram() +
    facet_wrap( ~ variables, scale = "free")

bmi_transforms_plot
```

`@sct`
```{r}
success_msg("Amazing!")
```

***

```yaml
type: NormalExercise
key: 8588b94514
xp: 50
```

`@instructions`
- Now do the same thing for cigarettes per day as you did for body mass index.

`@hint`
- Use the same code as you did for the body mass index, but for `cigarettes_per_day`.

`@sample_code`
```{r}
# Plot cigarettes per day transforms
cpd_transforms_plot <- transformed_framingham %>% 
    gather(variables, values, contains("___")) %>% 
    ggplot(aes(x = values)) +
    geom_histogram() +
    facet_wrap( ~ variables, scale = "free")

cpd_transforms_plot
```

`@solution`
```{r}
# Plot cigarettes per day transforms
cpd_transforms_plot <- transformed_framingham %>% 
    gather(variables, values, contains("cigarettes_per_day")) %>% 
    ggplot(aes(x = values)) +
    geom_histogram() +
    facet_wrap( ~ variables, scale = "free")

cpd_transforms_plot
```

`@sct`
```{r}
success_msg("Great! Check out how each transformation influences the distribution of body mass index and of number of cigarettes. Compare how the transformations affect the two variables differently.")
```

---

## How does the distribution change?

```yaml
type: MultipleChoiceExercise
key: ca708dca27
xp: 50
```

Understanding how each transformation influences the units and the distribution of the data is an important step in properly applying these transformations. Try answering these questions about the shape of the data after each transformation.

Both `bmi_transforms_plot` and `cpd_transforms_plot` are loaded for you to examine. Looking at the graphs, observe how each transformation influences the distribution of body mass index or cigarettes per day and think about how these new distributions might influence later analyses. Which statement is true?

`@possible_answers`
- Square root and scale don't change the distribution but do change the unit.
- Logarithm changes the distribution and unit.
- Body mass already has a good distribution and the original unit.
- Scale can make interpreting easier as 1 unit = 1 standard deviation of the original unit.
- All of the above.

`@hint`
- Look at the distribution of each transformation on body mass index, compared to the original distribution.

`@pre_exercise_code`
```{r}
transformed_framingham <- readRDS(url("https://assets.datacamp.com/production/repositories/2079/datasets/db4b0d894d5c2a05c8eab34f0432903694b8f8ad/transformed_framingham.Rds"))
library(tidyr)
library(dplyr)
library(ggplot2)

bmi_transforms_plot <- transformed_framingham %>% 
    gather(variables, values, contains("cigarettes_per_day")) %>% 
    ggplot(aes(x = values)) +
    geom_histogram() +
    facet_wrap( ~ variables, scale = "free")

cpd_transforms_plot <- transformed_framingham %>% 
    gather(variables, values, contains("body_mass_index")) %>% 
    ggplot(aes(x = values)) +
    geom_histogram() +
    facet_wrap( ~ variables, scale = "free")
```

`@sct`
```{r}
msg1 <- "Almost. While this is true, it's not the only true answer."
msg2 <- "Almost. While this is true, it's not the only true answer."
msg3 <- "Almost. While this is true, it's not the only true answer."
msg4 <- "Almost. While this is true, it's not the only true answer."
msg5 <- "Yes! Which type of and when you might transform really depends on the research question, the data values, and how you will want the results from your analyses to be interpreted. This means you need to carefully think about and have justifications for what you do to the data."
ex() %>% check_mc(5, feedback_msgs = c(msg1, msg2, msg3, msg4, msg5))
```
