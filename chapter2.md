---
title: 'Exploring, wrangling, and transforming cohort data'
description: ""
---

## Exploring before wrangling

```yaml
type: VideoExercise
key: f20c0dcfb8
xp: 50
```

`@projector_key`
146b85090bb8ab77efbfe45c5c751f5d

---

## Visualize variables at each visit

```yaml
type: BulletExercise
key: c6f4be6cde
xp: 100
```

Visually examining the data is an incredibly important early step in any data analysis project. In these series of exercises, you can visualize what the distribution of the data are for each variable. As we did in the previous chapter, you will be making heavy use of the `gather()` function to convert to long form in order to plot the data.

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
key: 2a85bae775
xp: 35
```

`@instructions`
- Select the blood measure variables (e.g. cholesterol, lipoprotein, glucose, blood pressure) and create histograms.

`@hint`
- The six variables are total cholesterol, systolic and diastolic blood pressure, fasting glucose, and high and low density lipoprotein.
- Use `geom_histogram()`.

`@sample_code`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the six blood measure variables
        ___
    ) %>%
    gather(variable, value, -followup_visit_number) %>%
    ggplot(aes(x = value)) +
    ___() +
    facet_grid(followup_visit_number ~ variable, scales = "free")
```

`@solution`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        total_cholesterol, 
        contains("lipoprotein"),
        ends_with("blood_pressure"),
        fasting_blood_glucose
    ) %>%
    gather(variable, value, -followup_visit_number) %>%
    ggplot(aes(x = value)) +
    geom_histogram() +
    facet_grid(followup_visit_number ~ variable, scales = "free")
```

`@sct`
```{r}
success_msg("Great! Notice the right skew to the blood pressure variables and the empty data for the lipoprotein variables at visits 1 and 2. These will be important to keep in mind.")
```

***

```yaml
type: NormalExercise
key: 7b93354589
xp: 35
```

`@instructions`
- Select the 5 overall participant characteristic (age, body mass, education, smoking status) and plot them.

`@hint`
- Use participant age, body mass index, education, currently smoking, and number of cigarettes per day.

`@sample_code`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the 5 charactistics
        ___
    ) %>%
    ___(variable, value, -followup_visit_number) %>%
    ___(aes(x = value)) +
    ___() +
    ___(followup_visit_number ~ variable, scales = "free")
```

`@solution`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        body_mass_index, participant_age,
        education, currently_smokes, cigarettes_per_day
    ) %>%
    gather(variable, value, -followup_visit_number) %>%
    ggplot(aes(x = value)) +
    geom_histogram() +
    facet_grid(followup_visit_number ~ variable, scales = "free")
```

`@sct`
```{r}
success_msg("Nice! Pay attention to the highest number of cigarettes smoked or how age has a jagged distribution. These are good things to keep in mind for later analyses.")
```

***

```yaml
type: NormalExercise
key: d6a3c7d607
xp: 30
```

`@instructions`
- Now do the same with for all the 5 prevalent cardiovascular events as well as the main outcome.

`@hint`
- Select the `got_cvd` as well as the prevalent MI, angina, CHD, hypertension, and stroke.

`@sample_code`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # 
        ___
    ) %>% 
```

`@solution`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        contains("prevalent"),
        got_cvd
    ) %>%
    gather(variable, value, -followup_visit_number) %>%
    ggplot(aes(x = value)) +
    geom_histogram() +
    facet_grid(followup_visit_number ~ variable, scales = "free")
```

`@sct`
```{r}
success_msg("Amazing! Did you notice how there is a high prevalence of hypertension and that it increases over time? Anyway, you've now visually checked nearly all of the more interesting variables!")
```

---

## Visually examine the outcomes with the exposures

```yaml
type: NormalExercise
key: e50ea375f8
xp: 100
```

{{convert to tab exercise}}

Create a simple visual comparing the outcome with the exposures.

`@instructions`


`@hint`


`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(dplyr)
library(tidyr)
library(ggplot2)
```

`@sample_code`
```{r}

```

`@solution`
```{r}
tidier_framingham %>% 
    select(followup_visit_number, got_cvd, total_cholesterol, participant_age, body_mass_index,
           cigarettes_per_day) %>% 
    mutate(got_cvd = as.character(got_cvd)) %>%
    gather(Variable, Value, -followup_visit_number, -got_cvd) %>% 
    ggplot(aes(y = Value, x = Variable, colour = got_cvd)) +
    geom_point(position = position_jitterdodge(dodge.width = 0.9)) +
    facet_grid(rows = vars(followup_visit_number), scales = "free") +
    coord_flip()
```

`@sct`
```{r}

```

---

## Tidying discrete data for later analysis

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
type: NormalExercise
key: d905b3eee0
xp: 100
```

As you will have noticed, there are several discrete variables with ambiguous values. For instance, with sex the values are either 1 or 2. Often you will encounter discrete data as integers rather than human understandable strings. But what exactly does that mean? With data like this, you need to have a data dictionary to review to find out.  Let's fix that problem and tidy up the data a bit more so it is human-readable.

`@instructions`
- Convert the education and sex values to human readable format using `case_when`.
- The original education numbers should correspond to the following strings: 1 = "0-11 years"; 2 = "High School"; 3 = "Vocational"; 4 = "College".
- The original sex numbers should correspond to the following strings: 1 = "Man"; 2 = "Woman".
- Confirm that the education and sex values have properly changed.

`@hint`
- The form for the `case_when` should look like `education == 1 ~ "0-11 years"`, for each number-string pairing.
- Use `count` with the `education` variable.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(forcats)
library(dplyr)
```

`@sample_code`
```{r}
# Convert education and sex to human-readable values
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = ___(
            # Use the format: variable == number ~ "string"
            ___ == ___ ~ ___, # do this for the four levels
            TRUE ~ NA_character_ # Need this as last value
            ),
        # Do the same thing with sex
        sex = ___
        )

# Confirm changes to revised education and sex
___(tidier2_framingham, ___)
___
```

`@solution`
```{r}
# Convert education to human-readable values
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_),
        sex = case_when(
            sex == 1 ~ "Man",
            sex == 2 ~ "Woman",
            TRUE ~ NA_character_))
# Confirm changes to revised education and sex
count(tidier2_framingham, education)
count(tidier2_framingham, sex)
```

`@sct`
```{r}
success_msg("Awesome! You've tidied up discrete values to be understandable to humans.")
```

---

## Merge factor categories together

```yaml
type: NormalExercise
key: 62bcf49a5e
xp: 100
```

Sometimes, categorical (i.e. factor or character) variables have many levels, but only a few observations in one or more levels. For some analyses or for particular questions, it might make sense to combine categories together. This is especially useful if we only want to interpret one level compared to the other levels.

`@instructions`
- Change the levels of Vocational and College education to be Post-Secondary by using `fct_recode` (forcats has been loaded).
- Confirm that the education values have been correctly merged by counting the new education variable.

`@hint`
- Make sure to capitalise the old and new education levels.
- Use `count` on the `education_combined` variable.
- Compare how the numbers differ between the original and the new education variable over each followup visit.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(forcats)
library(dplyr)
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            # Use the format: variable == number ~ "string"
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            # Need this as last value
            TRUE ~ NA_character_
            ),
        sex = case_when(
            sex == 1 ~ "Man",
            sex == 2 ~ "Woman",
            # Need this as last value
            TRUE ~ NA_character_
            )
        )
```

`@sample_code`
```{r}
# Merge college and vocational levels together
tidier2_framingham <- tidier2_framingham %>% 
    mutate(education_combined = ___(
        education, 
        # Form is: "new" = "old"
        ___ = ___,
        ___ = ___
        ))

# Confirm changes to the new combined education
___(tidier2_framingham, ___)

# Compare counts of education and the combined version with visit number
___
___
```

`@solution`
```{r}
# Merge college and vocational levels together
tidier2_framingham <- tidier2_framingham %>% 
    mutate(education_combined = fct_recode(
        education, 
        # Form is: "new" = "old"
        "Post-Secondary" = "College",
        "Post-Secondary" = "Vocational"
        ))

# Confirm changes to the new combined education
count(tidier2_framingham, education_combined)

# Compare the count of education with the combined version
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
- Log, log10, square root, and invert the values of body mass index and cigarettes per day.

`@hint`
- Use the `body_mass_index` and the `cigarettes_per_day` variables.
- Use `log`, `log10`, and `sqrt` to transform the values.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(dplyr)
library(tidyr)
library(ggplot2)
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            # Use the format: variable == number ~ "string"
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            # Need this as last value
            TRUE ~ NA_character_
            ),
        sex = case_when(
            sex == 1 ~ "Man",
            sex == 2 ~ "Woman",
            # Need this as last value
            TRUE ~ NA_character_
            )
        ) %>% 
    mutate(education_combined = forcats::fct_recode(
        education, 
        # Form is: "new" = "old"
        "Post-Secondary" = "College",
        "Post-Secondary" = "Vocational"
        ))
```

`@sample_code`
```{r}
# Create invert function for easy use in mutate
invert <- function(x) 1 / x

# Use four transformations on body mass index
transformed_framingham <- tidier2_framingham %>% 
    mutate_at(vars(___, ___), 
              funs(___, ___, ___, invert))

# Confirm variables have been created
summary(___)
```

`@solution`
```{r}
# Create invert function for easy use in mutate
invert <- function(x) 1 / x

# Use four transformations on body mass index
transformed_framingham <- tidier_framingham %>% 
    mutate_at(vars(body_mass_index, cigarettes_per_day), 
              funs(log, log10, sqrt, invert))

# Confirm variables have been created
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
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(dplyr)
library(tidyr)
library(ggplot2)
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            # Use the format: variable == number ~ "string"
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            # Need this as last value
            TRUE ~ NA_character_
            ),
        sex = case_when(
            sex == 1 ~ "Man",
            sex == 2 ~ "Woman",
            # Need this as last value
            TRUE ~ NA_character_
            )
        ) %>% 
    mutate(education_combined = forcats::fct_recode(
        education, 
        # Form is: "new" = "old"
        "Post-Secondary" = "College",
        "Post-Secondary" = "Vocational"
        ))
invert <- function(x) 1 / x
transformed_framingham <- tidier2_framingham %>% 
    mutate_at(vars(body_mass_index, cigarettes_per_day), 
              funs(invert, log, log10, sqrt))
```

***

```yaml
type: NormalExercise
key: e0ccd581d4
xp: 50
```

`@instructions`
- Convert the dataset into the long form for the body mass index variables. Then create a ggplot histogram.

`@hint`
- Use `gather` to convert to long form.
- Name the key argument  `variables` and the value argument `values`.
- Use `geom_histogram` as a ggplot layer.
- Have `x = values` as the aesthetic.

`@sample_code`
```{r}
# Visually inspect the transformations for body mass index
transformed_framingham %>% 
    ___(variables, values, contains("___")) %>% 
    ___(___(x = values)) +
    ___ +
    # All histograms can be easily seen with facet and free scales
    facet_wrap( ~ variables, scale = "free")
```

`@solution`
```{r}
# Visually inspect the transformations for body mass index
transformed_framingham %>% 
    gather(variables, values, contains("body_mass_index")) %>% 
    ggplot(aes(x = values)) +
    geom_histogram() +
    # All histograms can be easily seen with facet and free scales
    facet_wrap( ~ variables, scale = "free")
```

`@sct`
```{r}
success_msg("Amazing! Check out how each transformation influences the distribution of body mass index.")
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
# Visually inspect the transformations for cigarettes per day
transformed_framingham %>% 
    gather(variables, values, contains("___")) %>% 
    ggplot(aes(x = values)) +
    geom_histogram() +
    # All histograms can be easily seen with facet and free scales
    facet_wrap( ~ variables, scale = "free", ncol = 3)
```

`@solution`
```{r}
# Visually inspect the transformations for cigarettes per day
transformed_framingham %>% 
    gather(variables, values, contains("cigarettes_per_day")) %>% 
    ggplot(aes(x = values)) +
    geom_histogram() +
    # All histograms can be easily seen with facet and free scales
    facet_wrap( ~ variables, scale = "free", ncol = 3)
```

`@sct`
```{r}
success_msg("Great! Compare how the transformations affect the cigarettes data compared to the body mass index data.")
```

---

## How does the distribution change?

```yaml
type: TabExercise
key: ca708dca27
xp: 100
```

Understanding how each transformation influences the units and the distribution of the data is an important step in properly applying these transformations. Try answering these questions about the shape of the data after each transformation.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(dplyr)
library(tidyr)
library(ggplot2)
invert <- function(x) 1 / x
transformed_framingham <- tidier_framingham %>% 
    mutate_at(vars(body_mass_index, cigarettes_per_day), 
              funs(invert, log, log10, sqrt))
```

`@sample_code`
```{r}
# Visually inspect the transformations for body mass index 
# (or for cigarettes per day)
transformed_framingham %>% 
    gather(variables, values, contains("___")) %>% 
    ggplot(aes(x = values)) +
    geom_histogram() +
    facet_wrap( ~ variables, scale = "free", ncol = 3)
```

***

```yaml
type: MultipleChoiceExercise
key: 58373c7c64
xp: 50
```

`@question`
Looking at the graph, observe how each transformation influences the distribution of body mass index and think about how these new distributions might influence later analyses. Which statement is true?

`@possible_answers`
- Taking the square root and scaling doesn't change the distribution but does change the unit.
- Taking the logarthm changes the distribution and the unit.
- For later analyses, body mass index already has a good distribution and has the original unit, so interpretation will be easier if no transformations are used.
- For later analyses, taking the scale can make interpretation easy since one unit is equal to one standard deviation of the original unit.
- All of the above.

`@hint`
- Look at the distribution of each transformation on body mass index, compared to the original distribution.

`@sct`
```{r}
msg1 <- "Almost. While this is true, it's not the only true answer."
msg2 <- "Almost. While this is true, it's not the only true answer."
msg3 <- "Almost. While this is true, it's not the only true answer."
msg4 <- "Almost. While this is true, it's not the only true answer."
msg5 <- "Yes! Which type of and when you might transform really depends on the research question, the data values, and how you will want the results from your analyses to be interpreted. This means you need to carefully think about and have justifications for what you do to the data."
ex() %>% check_mc(5, feedback_msgs = c(msg1, msg2, msg3, msg4, msg5))
```

***

```yaml
type: MultipleChoiceExercise
key: 3c5705a42e
xp: 50
```

`@question`
The cigarettes per day variable contains count data with a large number of zero values. Because of this, there are some problems and other considerations to think about. Look at the distribution of the data and at the warning messages. Which of following statements is true?

`@possible_answers`
- Some transformations aren't appropriate. For instance, the log of 0 doesn't work (`log(0)` = `-Inf`), so there will be many missing values.
- There seems to be two "peaks", one at zero and one at 20. Depending on the research question, you could convert this variable to a categorical variable.
- Most values seem to be zero. Depending on the research question, you could dichotomize this variable.
- All of the above. 
- None of the above.

`@hint`
- Notice the warning message and check the summary of the transformed data.
- Look at the distribution of each transformation on cigarettes per day.

`@sct`
```{r}
msg1 <- "Almost. While this is true, it's not the only true answer."
msg2 <- "Almost. While this is true, it's not the only true answer."
msg3 <- "Almost. While this is true, it's not the only true answer."
msg4 <- "That's right! Some transformations won't work with this data. One way of dealing with zeros is by adding 0.5 to all the values. However, you'll also notice that there are two peaks in the data, so it has a bimodal distribution. Because of this, most transformations won't fix this. Generally it's a bad idea to convert continuous variables to discrete variables. However, depending on the data and the research questions, this can sometimes be appropriate to do. Especially considering that this is 'memory recall' data, and not directly measured, so there will be more noise in the data."
msg5 <- "Incorrect. One of the above has the right answer."
ex() %>% check_mc(4, feedback_msgs = c(msg1, msg2, msg3, msg4, msg5))
```
