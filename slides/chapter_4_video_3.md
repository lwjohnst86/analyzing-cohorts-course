---
title: Use tables effectively to show your results
key: 8ecd82ad25933a2add144c7e10605b7d

---
## Use tables effectively to show your results

```yaml
type: "TitleSlide"
key: "42d0b454fb"
```

`@lower_third`

name: Luke Johnston
title: Diabetes epidemiologist


`@script`
Sadly we can't have everything as figures. Tables can also be useful for communicating certain types of results.


---
## When are tables preferred?

```yaml
type: "FullSlide"
key: "2b772c0d95"
```

`@part1`
Basically, *whenever you can't use figures* {{1}}

- Units are dissimilar {{2}}
- Items are distinct and/or not comparable {{2}}
- Different model types {{3}}
- To provide the actual raw values {{4}}


`@script`
When is it best to use tables? Basically, whenever you can't use figures. 

Use tables when, for example, the units of measure are too dissimilar, when the items are distinct or comparison between them isn't important, when presenting multiple but different models, or when you want to show the raw numbers so it's easier to extract it.


---
## Creating a table of participant characteristics

```yaml
type: "FullSlide"
key: "ed9bf55a56"
disable_transition: false
```

`@part1`
```{r}
library(carpenter)
tidied_framingham %>%
    outline_table()
``` 
{{1}}

```
# A tibble: 0 x 0
``` 
{{2}}

```{r}
tidied_framingham %>%
    outline_table() %>%
    add_rows("education_combined", stat = stat_nPct)
```
{{3}}

```
# A tibble: 4 x 2
  Variables          all         
  <chr>              <chr>       
1 education_combined NA          
2 - 0-11 years       4690 (41.4%)
3 - Post-Secondary   3232 (28.5%)
4 - High School      3410 (30.1%)
``` 
{{4}}


`@script`
Presenting basic participant characteristics, as indicated by STROBE best practices, is a great example for using a table. Here you can show summary statistics of the outcomes, predictors, and other characteristics.

The carpenter package provides an easy way of creating these tables. We start by using outline-underscore-table, piping in the data. This function also takes a argument to set the grouping variable, such as visit number, so they are arranged as the table columns. We haven't added rows, so it outputs nothing.. 

Let's use add-underscore-rows and add a factor variable like combined education. A common statistic for factors is the count with percent of total, so let's set stat to stat-underscore-n-percent.


---
## Creating a table of participant characteristics

```yaml
type: "FullSlide"
key: "a6b86785d3"
disable_transition: true
```

`@part1`
```{r}
tidied_framingham %>%
    outline_table() %>%
    add_rows("education_combined", stat = stat_nPct) %>%
    add_rows("body_mass_index", stat = stat_meanSD) %>%
    add_rows(c("participant_age", "heart_rate"),
             stat = stat_medianIQR)
``` 
{{1}}

```
# A tibble: 7 x 2
  Variables          all             
  <chr>              <chr>           
1 education_combined NA              
2 - 0-11 years       4690 (41.4%)    
3 - Post-Secondary   3232 (28.5%)    
4 - High School      3410 (30.1%)    
5 body_mass_index    25.9 (4.1)      
6 participant_age    54.0 (48.0-62.0)
7 heart_rate         75.0 (69.0-85.0)
``` 
{{2}}


`@script`
Now let's add some more rows to the table for BMI, using stat-underscore-mean-sd for the mean and standard deviation, and participant age and heart rate, using stat-underscore-median-iqr for the median and interquartile range.


---
## Renaming table headers

```yaml
type: "FullSlide"
key: "be6655fec1"
```

`@part1`
```{r}
basic_char_table <- tidied_framingham %>%
    outline_table() %>%
    add_rows("education_combined", stat = stat_nPct) %>%
    add_rows("body_mass_index", stat = stat_meanSD) %>%
    add_rows(c("participant_age", "heart_rate"),
             stat = stat_medianIQR) %>%
    renaming("header", c("", "Characteristics"))
basic_char_table
```
{{1}}

```
# A tibble: 7 x 2
  ``                 Characteristics 
  <chr>              <chr>           
1 education_combined NA              
2 - 0-11 years       4690 (41.4%)    
3 - Post-Secondary   3232 (28.5%)    
4 - High School      3410 (30.1%)    
5 body_mass_index    25.9 (4.1)      
6 participant_age    54.0 (48.0-62.0)
7 heart_rate         75.0 (69.0-85.0)
``` 
{{2}}


`@script`
Great! But the table headers aren't informative. We set them using the renaming function and the header argument, then set the new names for the columns. We'll name only one column as Characteristics.


---
## Render data into actual table

```yaml
type: "FullSlide"
key: "2ecaa9f305"
```

`@part1`
```{r}
build_table(basic_char_table)
```

|                    | Characteristics  |
|:-------------------|:----------------:|
| education_combined |                  |
| - 0-11 years       |   4690 (41.4%)   |
| - Post-Secondary   |   3232 (28.5%)   |
| - High School      |   3410 (30.1%)   |
| body_mass_index    |    25.9 (4.1)    |
| participant_age    | 54.0 (48.0-62.0) |
| heart_rate         | 75.0 (69.0-85.0) | {{1}}


`@script`
If you use R Markdown, we can use build-underscore-table to convert the output into a Markdown table. Now you have a basic characteristics table to use when presenting your cohort analysis!


---
## Wrangling model results into table format

```yaml
type: "FullSlide"
key: "82f46fe854"
```

`@part1`
**Example table showing model estimates and confidence interval**: {{1}}

|Predictors              |Unadjusted          |Adjusted            |
|:-----------------------|:-------------------|:-------------------|
|Fasting blood glucose   |1.55 (0.78 to 3.09) |1.52 (0.75 to 3.07) |
|Systolic blood pressure |1.86 (0.8 to 4.29)  |1.86 (0.78 to 4.43) | {{1}}

How to get this? {{2}}


`@script`
At times you may need to present either your main or supplemental results as a table. Even if you present your main findings as a figure, providing the model estimates as text numbers could be helpful for other researchers who might use your findings as part of a meta-analysis of cohort studies. Here, we're showing the confidence interval.

So, how do we get our results into this form?


---
## Wrangling data into table form

```yaml
type: "FullSlide"
key: "2de3b37bbf"
```

`@part1`
```{r}
library(glue)
models %>%
    mutate_at(vars(estimate, conf.low, conf.high), round, digits = 2) %>%
    mutate(estimate_ci = glue("{estimate} ({conf.low} to {conf.high})")) %>%
    select(model, predictor, estimate_ci)
``` 
{{1}}

```
# A tibble: 4 x 3
  model      predictor               estimate_ci        
  <chr>      <chr>                   <S3: glue>         
1 unadjusted systolic_blood_pressure 1.86 (0.8 to 4.29) 
2 unadjusted fasting_blood_glucose   1.55 (0.78 to 3.09)
3 adjusted   systolic_blood_pressure 1.86 (0.78 to 4.43)
4 adjusted   fasting_blood_glucose   1.52 (0.75 to 3.07)
``` 
{{1}}


`@script`
Most of these functions should be familiar, except for glue. As a reminder, mutate-at applies a function to each variable contained within the vars function. Here we are rounding the variable's values to two. 

Next, we again use mutate but with the glue function. Glue helps create a character string that changes based on the variable given between the curly braces. We use glue to format a string with the estimate and confidence interval in brackets. 

Finally, let's keep the most relevant variables and output the dataframe.


---
## Spreading rows across to make table columns

```yaml
type: "FullSlide"
key: "a685b99001"
disable_transition: true
```

`@part1`
```{r}
table_models <- models %>%
    mutate_at(vars(estimate, conf.low, conf.high), round, digits = 2) %>%
    mutate(estimate_ci = glue("{estimate} ({conf.low} to {conf.high})")) %>%
    select(model, predictor, estimate_ci) %>%
    spread(model, estimate_ci)
table_models
```

```
# A tibble: 2 x 3
  predictor               adjusted            unadjusted         
  <chr>                   <S3: glue>          <S3: glue>         
1 fasting_blood_glucose   1.52 (0.75 to 3.07) 1.55 (0.78 to 3.09)
2 systolic_blood_pressure 1.86 (0.78 to 4.43) 1.86 (0.8 to 4.29) 
``` 
{{1}}


`@script`
Next, by using the spread function from tidyr, the models will be represented as individual columns. The first argument to spread takes the model variable name that will represent the new columns while the second argument takes the estimate-underscore-ci variable that has the values that will make up the new columns.

So, with minimal code, we've gotten the results to appear very similar to our desired table.


---
## Create R Markdown table with kable

```yaml
type: "FullSlide"
key: "e94dd5cdce"
```

`@part1`
```{r}
library(knitr)
library(stringr)
table_models %>% 
    mutate(predictor = str_replace_all(predictor, "_", " ")) %>% 
    kable()
```

|predictor               |adjusted            |unadjusted          |
|:-----------------------|:-------------------|:-------------------|
|fasting blood glucose   |1.52 (0.75 to 3.07) |1.55 (0.78 to 3.09) |
|systolic blood pressure |1.86 (0.78 to 4.43) |1.86 (0.8 to 4.29)  |


`@script`
We could continue to replace underscores with spaces using the str-underscore-replace-underscore-all function from stringr. Like many search and replace functions, give arguments for the character vector, the string to search for, and the replacement string. If you use rmarkdown, the kable function from knitr can create nicely formatted table.


---
## Time to create some tables!

```yaml
type: "FinalSlide"
key: "ccbe649640"
```

`@script`
Now let's try making some tables!

