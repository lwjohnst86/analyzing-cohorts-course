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
- Select the cholesterol based variables, including total and lipoproteins, and create histograms.

`@hint`
- The three variables are total cholesterol and high and low-density lipoprotein.
- Use `geom_histogram()` to create the histograms.

`@sample_code`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the three cholesterol-based variables
        ___
    ) %>%
    gather(variable, value, -followup_visit_number) %>%
    ggplot(aes(x = value)) +
    # Add histogram layer
    ___() +
    facet_grid(followup_visit_number ~ variable, scales = "free")
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
    # Add histogram layer
    geom_histogram() +
    facet_grid(followup_visit_number ~ variable, scales = "free")
```

`@sct`
```{r}
success_msg("Great!")
```

***

```yaml
type: NormalExercise
key: 7b93354589
xp: 35
```

`@instructions`
- Select and plot the following three overall participant characteristics: age, body mass, and cigarettes smoked.

`@hint`
- Use participant age, body mass index, and number of cigarettes per day.

`@sample_code`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the three charactistics
        ___
    ) %>%
    # Convert to long form
    ___(variable, value, -followup_visit_number) %>%
    # Plot histograms
    ___(aes(x = value)) +
    ___() +
    ___(followup_visit_number ~ variable, scales = "free")
```

`@solution`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the three charactistics
        body_mass_index, participant_age, cigarettes_per_day
    ) %>%
    # Convert to long form
    gather(variable, value, -followup_visit_number) %>%
    # Plot histograms
    ggplot(aes(x = value)) +
    geom_histogram() +
    facet_grid(followup_visit_number ~ variable, scales = "free")
```

`@sct`
```{r}
success_msg("Nice!")
```

***

```yaml
type: NormalExercise
key: d6a3c7d607
xp: 30
```

`@instructions`
- Select and plot prevalent hypertension and CHD events, as well as the main outcome.

`@hint`
- Select the `got_cvd` variable, as well as prevalent MI and CHD.

`@sample_code`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the three cardiovascular variables
        ___
    ) %>% 
    # Convert to long form
    ___(variable, value, -followup_visit_number) %>%
    # Plot histograms
    ___(aes(x = value)) +
    ___() +
    ___(followup_visit_number ~ variable, scales = "free")
```

`@solution`
```{r}
tidier_framingham %>%
    select(
        followup_visit_number,
        # Select the three cardiovascular variables
        prevalent_hypertension, prevalent_chd, got_cvd
    ) %>%
    # Convert to long form
    gather(variable, value, -followup_visit_number) %>%
    # Plot histograms
    ggplot(aes(x = value)) +
    geom_histogram() +
    facet_grid(followup_visit_number ~ variable, scales = "free")
```

`@sct`
```{r}
success_msg("Amazing! Did you notice a few things? The empty data for the lipoprotein variables at visits 1 and 2. The high number of zero cigarettes smoked. How age has a jagged distribution. The high prevalence of hypertension and that it increases over time. These are all important things to keep in mind for later analyses. Anyway, you've now visually checked many of the more interesting variables!")
```

---

## Visually examine the outcomes with the exposures

```yaml
type: NormalExercise
key: e50ea375f8
xp: 100
```

Create multiple boxplots of several exposures with the outcome. Use a combination of converting to long data form, grouping to show the outcome, and facetting by year to show temporal changes.

`@instructions`
- Select participant age, total cholesterol, body mass, and systolic and diastolic blood pressure.
- Convert to long data form, excluding visit number and the outcome.
- Create boxplots, coloured by the outcome.
- Facet by visit number.

`@hint`
- Select `total_cholesterol`, `participant_age`, `body_mass_index`, `systolic_blood_pressure`, and `diastolic_blood_pressure`.
- Use `gather` and exclude the followup visit number and the `got_cvd` outcome.
- Create `geom_boxplots`, coloured by `got_cvd`.
- Use the `vars()` function to wrap the variable name in `facet_grid`.

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
# Convert to long form and make multiple box plots over time
tidier_framingham %>% 
    select(followup_visit_number, got_cvd, 
           # Select the 5 continuous variables
           ___) %>% 
    # Convert to long form
    ___(variable, value, -___, -___) %>% 
    ggplot(aes(y = value, x = variable, colour = ___)) +
    # Plot boxplots
    ___() +
    facet_grid(rows = ___) +
    # To have horizontal boxplots
    coord_flip()
```

`@solution`
```{r}
# Convert to long form and make multiple box plots over time
tidier_framingham %>% 
    select(followup_visit_number, got_cvd, 
           # Select the 5 continuous variables
           total_cholesterol, participant_age, body_mass_index,
           systolic_blood_pressure, diastolic_blood_pressure) %>% 
    # Convert to long form
    gather(variable, value, -followup_visit_number, -got_cvd) %>% 
    ggplot(aes(y = value, x = variable, colour = got_cvd)) +
    # Plot boxplots
    geom_boxplot() +
    facet_grid(rows = vars(followup_visit_number)) +
    # To have horizontal boxplots
    coord_flip()
```

`@sct`
```{r}
success_msg("Excellent! You quickly created a figure showing several continuous variables by the outcome, and over time! Notice how some variables are a bit higher in the `got_cvd` group and that over time these differences decreased?")
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
type: TabExercise
key: e916c33326
xp: 100
```

As you will have noticed, there are several discrete variables with ambiguous values. For instance, with sex the values are either 1 or 2. Often you will encounter discrete data as integers rather than human understandable strings. But what exactly does that mean? With data like this, you need to have a data dictionary to review to find out.  Let's fix that problem and tidy up the data a bit more so it is human-readable.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(forcats)
library(dplyr)
```

***

```yaml
type: NormalExercise
key: cbc1123965
xp: 35
```

`@instructions`
- Convert the education values to human readable format using `case_when`.
- The original education numbers should correspond to the following strings: 1 = "0-11 years"; 2 = "High School"; 3 = "Vocational"; 4 = "College".

`@hint`
- The form for the `case_when` should look like `education == 1 ~ "0-11 years"`, for each number-string pairing.

`@sample_code`
```{r}
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = ___(
            # Use the format: variable == number ~ "string"
            ___ == ___ ~ ___, 
            TRUE ~ NA_character_)
      )
```

`@solution`
```{r}
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            # Use the format: variable == number ~ "string"
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_)
      )
```

`@sct`
```{r}
success_msg("Excellent!")
```

***

```yaml
type: NormalExercise
key: 93db7dd67f
xp: 35
```

`@instructions`
- Convert the sex values to human readable format using `case_when`.
- The original sex numbers should correspond to the following strings: 1 = "Man"; 2 = "Woman".

`@hint`
- The form for the `case_when` should look like `sex == 1 ~ "Man"`, for each number-string pairing.

`@sample_code`
```{r}
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            # Use the format: variable == number ~ "string"
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_),
        # Do the same thing for sex
        sex = ___
        )
```

`@solution`
```{r}
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            # Use the format: variable == number ~ "string"
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_),
        # Do the same thing for sex  
        sex = case_when(
            sex == 1 ~ "Man",
            sex == 2 ~ "Woman",
            TRUE ~ NA_character_)
    )
```

`@sct`
```{r}
success_msg("Excellent!")
```

***

```yaml
type: NormalExercise
key: 41077e061c
xp: 30
```

`@instructions`
- Confirm that the education and sex values have properly changed.

`@hint`
- Use `count` with the `education` and `sex` variables.

`@sample_code`
```{r}
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
            TRUE ~ NA_character_)
    )

# Confirm changes to the two variables
___(tidier2_framingham, ___)
___
```

`@solution`
```{r}
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

# Confirm changes to the two variables
count(tidier2_framingham, education)
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
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_
            ),
        sex = case_when(
            sex == 1 ~ "Man",
            sex == 2 ~ "Woman",
            TRUE ~ NA_character_
            )
        )
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

`@hint`
- Use the `body_mass_index` and the `cigarettes_per_day` variables.
- Use `log` and `sqrt` to transform the values.

`@pre_exercise_code`
```{r}
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(dplyr)
library(tidyr)
library(ggplot2)
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_
            ),
        sex = case_when(
            sex == 1 ~ "Man",
            sex == 2 ~ "Woman",
            TRUE ~ NA_character_
            )
        ) %>% 
    mutate(education_combined = forcats::fct_recode(
        education, 
        "Post-Secondary" = "College",
        "Post-Secondary" = "Vocational"
        ))
```

`@sample_code`
```{r}
# Function so invert name is appended to variable
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
# Function so invert name is appended to variable
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
load(url("http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/dee4084963a4701f406fdf9db21e66302da4a05a/framingham_tidier.rda"))
library(dplyr)
library(tidyr)
library(ggplot2)
tidier2_framingham <- tidier_framingham %>% 
    mutate(
        education = case_when(
            education == 1 ~ "0-11 years",
            education == 2 ~ "High School",
            education == 3 ~ "Vocational",
            education == 4 ~ "College",
            TRUE ~ NA_character_
            ),
        sex = case_when(
            sex == 1 ~ "Man",
            sex == 2 ~ "Woman",
            TRUE ~ NA_character_
            )
        ) %>% 
    mutate(education_combined = forcats::fct_recode(
        education, 
        "Post-Secondary" = "College",
        "Post-Secondary" = "Vocational"
        ))
invert <- function(x) 1 / x
transformed_framingham <- tidier2_framingham %>% 
    mutate_at(vars(body_mass_index, cigarettes_per_day), 
              funs(invert, log, sqrt))
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
# Plot body mass index transforms
transformed_framingham %>% 
    ___(variables, values, contains("___")) %>% 
    ___(___(x = values)) +
    ___ +
    # Facets show all histograms
    facet_wrap( ~ variables, scale = "free")
```

`@solution`
```{r}
# Plot body mass index transforms
transformed_framingham %>% 
    gather(variables, values, contains("body_mass_index")) %>% 
    ggplot(aes(x = values)) +
    geom_histogram() +
    # Facets show all histograms
    facet_wrap( ~ variables, scale = "free")
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
transformed_framingham %>% 
    gather(variables, values, contains("___")) %>% 
    ggplot(aes(x = values)) +
    geom_histogram() +
    # Facets show all histograms
    facet_wrap( ~ variables, scale = "free")
```

`@solution`
```{r}
# Plot cigarettes per day transforms
transformed_framingham %>% 
    gather(variables, values, contains("cigarettes_per_day")) %>% 
    ggplot(aes(x = values)) +
    geom_histogram() +
    # Facets show all histograms
    facet_wrap( ~ variables, scale = "free")
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

Looking at the graph, observe how each transformation influences the distribution of body mass index and think about how these new distributions might influence later analyses. Which statement is true?

`@possible_answers`
- Square root and scale don't change the distribution but do to the unit.
- Logarithm changes the distribution and unit.
- Body mass already has a good distribution and the original unit.
- Scale can make interpreting easier as 1 unit = 1 standard deviation of the original unit.
- All of the above.

`@hint`
- Look at the distribution of each transformation on body mass index, compared to the original distribution.

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

`@sct`
```{r}
msg1 <- "Almost. While this is true, it's not the only true answer."
msg2 <- "Almost. While this is true, it's not the only true answer."
msg3 <- "Almost. While this is true, it's not the only true answer."
msg4 <- "Almost. While this is true, it's not the only true answer."
msg5 <- "Yes! Which type of and when you might transform really depends on the research question, the data values, and how you will want the results from your analyses to be interpreted. This means you need to carefully think about and have justifications for what you do to the data."
ex() %>% check_mc(5, feedback_msgs = c(msg1, msg2, msg3, msg4, msg5))
```
