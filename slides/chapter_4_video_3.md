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
title: Instructor


`@script`
Sadly we can't have everything as graphs. Tables can be quite useful for communicating certain types of results.


---
## When are tables preferred?

```yaml
type: "FullSlide"
key: "2b772c0d95"
```

`@part1`
Basically, *whenever you can't use graphs* {{1}}

- Units are dissimilar {{2}}
- Items are distinct and/or not comparable {{2}}
- Different model types {{3}}
- To provide the actual raw values {{4}}


`@script`
When is it best to use tables? Basically, whenever you can't use a graph. Use a table when, for example, the units of measure are too dissimilar, when the items are distinct or comparison between them isn't important, when presenting multiple but different models, or when you want to show the raw numbers so it's easier to extract it.


---
## Creating a table of participant characteristics

```yaml
type: "TwoColumns"
key: "ee670c18b4"
```

`@part1`
```{r}
library(carpenter)
diet %>%
    outline_table()
``` 
{{1}}

```
# A tibble: 0 x 0
``` 
{{2}}

```{r}
diet %>%
    outline_table() %>%
    add_rows("job", stat = stat_nPct)
```
{{3}}

```
# A tibble: 4 x 2
  Variables     all        
  <chr>         <chr>      
1 job           NA         
2 - Bank worker 151 (44.8%)
3 - Conductor   84 (24.9%) 
4 - Driver      102 (30.3%)
``` 
{{4}}


`@part2`
```{r}
diet %>%
    outline_table() %>%
    add_rows("job", 
             stat = stat_nPct) %>%
    add_rows("fibre", 
             stat = stat_meanSD) %>%
    add_rows(c("energy", "weight"), 
             stat = stat_medianIQR)
``` 
{{5}}

```
# A tibble: 7 x 2
  Variables     all             
  <chr>         <chr>           
1 job           NA              
2 - Bank worker 151 (44.8%)     
3 - Conductor   84 (24.9%)      
4 - Driver      102 (30.3%)     
5 fibre         1.7 (0.6)       
6 energy        28.0 (25.4-31.1)
7 weight        72.8 (64.6-79.8)
``` 
{{6}}


`@script`
Presenting basic participant characteristics, as suggested by STROBE, is a great example for using a table. Here you can show summary statistics of the outcomes, the predictors, and other characteristics.

The carpenter package provides an easy way of creating these tables. We start by outlining the table based on the data. With multiple time points, you could indicate the time variable so that each time point has a column. This outputs nothing right now as we haven't added rows. 

Next, we add a row for the factor variable jobs. A common summary statistic for factors is count showing percent of total, so we set the stat to n percent.

Let's add rows to the table for fibre, using the mean and standard deviation, and energy and weight, using median and interquartile range.


---
## Renaming table headers

```yaml
type: "FullSlide"
key: "be6655fec1"
```

`@part1`
```{r}
basic_char_table <- diet %>%
    outline_table() %>%
    add_rows("job", stat = stat_nPct) %>%
    add_rows("fibre", stat = stat_meanSD) %>%
    add_rows(c("energy", "weight"), stat = stat_medianIQR) %>%
    renaming("header", c("", "Characteristics"))
basic_char_table
```
{{1}}

```
# A tibble: 7 x 2
  ``            Characteristics 
  <chr>         <chr>           
1 job           NA              
2 - Bank worker 151 (44.8%)     
3 - Conductor   84 (24.9%)      
4 - Driver      102 (30.3%)     
5 fibre         1.7 (0.6)       
6 energy        28.0 (25.4-31.1)
7 weight        72.8 (64.6-79.8)
``` 
{{2}}


`@script`
Great! But the table headers aren't informative. We set them using the renaming function, using the argument header and providing the names of each column. Here we added a single column called Characteristics.


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

| Characteristics |      Values      |
|:----------------|:----------------:|
| job             |                  |
| - Bank worker   |   151 (44.8%)    |
| - Conductor     |    84 (24.9%)    |
| - Driver        |   102 (30.3%)    |
| fibre           |    1.7 (0.6)     |
| energy          | 28.0 (25.4-31.1) |
| weight          | 72.8 (64.6-79.8) | {{1}}


`@script`
If you use R Markdown, we can use the build-underscore-table function to convert this table data into a Markdown table. Now you have a basic characteristics table to use when presenting your cohort analysis!


---
## Wrangling model results into table format

```yaml
type: "FullSlide"
key: "82f46fe854"
```

`@part1`
**Example table showing model estimates and standard errors**: {{1}}

|           |Unadjusted     |Adjusted       |
|:----------|:--------------|:--------------|
|Energy     |0.89 (0.04 SE) |0.89 (0.04 SE) |
|Fibre      |0.33 (0.38 SE) |0.35 (0.41 SE) | {{1}}

How to get this? {{2}}


`@script`
At times you may need to present either your main results or a supplement as a table. Even if you present your main findings as a figure, providing the raw numerical model estimates in a machine-friendly format is helpful for other researchers who might use your findings as part of a meta-analysis of cohort studies. Here, the standard error is shown, which is another measure of precision like the confidence interval.

So, how do we wrangle the results to get a table like this?


---
## Glue: Very useful package for wrangling into tables

```yaml
type: "FullSlide"
key: "7a6f6ba0ae"
```

`@part1`
```{r}
library(glue)
x <- 3
y <- 5
glue("{x} ({y}%)")
``` 
{{1}}

```
3 (5%)
``` 
{{2}}


`@script`
The glue function from the glue package helps create a character string and insert data into that string between curly braces. Here, glue is used to replace the y with 5.


---
## Combining dplyr and glue to prepare data

```yaml
type: "FullSlide"
key: "2de3b37bbf"
```

`@part1`
```{r}
library(dplyr)
models %>%
    select(model, predictor, estimate, std.error) %>%
    mutate_at(vars(estimate, std.error), round, digits = 2) %>%
    mutate(estimate_se = glue("{estimate} ({std.error} SE)"))
``` 
{{1}}

```
# A tibble: 4 x 5
  model      predictor estimate std.error estimate_se   
  <chr>      <chr>        <dbl>     <dbl> <S3: glue>    
1 unadjusted energy        0.89      0.04 0.89 (0.04 SE)
2 unadjusted fibre         0.33      0.38 0.33 (0.38 SE)
3 adjusted   energy        0.89      0.04 0.89 (0.04 SE)
4 adjusted   fibre         0.35      0.41 0.35 (0.41 SE)
``` 
{{2}}


`@script`
Other than the glue function, the remaining functions used here should be familiar from previous discussions. We use select to choose the relevant variables and mutate at to round the values. Then we use mutate again but with the glue function, formatted so the standard error is in brackets.

We see from the output the new column with the combined estimate and standard error.


---
## Spreading rows across to make table columns

```yaml
type: "FullSlide"
key: "a685b99001"
disable_transition: true
```

`@part1`
```{r}
library(dplyr)
library(tidyr)
models %>%
    select(model, predictor, estimate, std.error) %>%
    mutate_at(vars(estimate, std.error), round, digits = 2) %>%
    mutate(estimate_se = glue("{estimate} ({std.error} SE)")) %>%
    select(predictor, model, estimate_se) %>%
    spread(model, estimate_se)
```

```
# A tibble: 2 x 3
  predictor adjusted       unadjusted    
  <chr>     <S3: glue>     <S3: glue>    
1 energy    0.89 (0.04 SE) 0.89 (0.04 SE)
2 fibre     0.35 (0.41 SE) 0.33 (0.38 SE)
``` 
{{1}}


`@script`
Next, using the spread function from the tidyr package, the models will be represented as columns. The first argument takes the model variable that groups the results and the second argument takes the estimate se variable that has the values making up the new columns. We should select only relevant columns before spreading.

Great! With minimal code, we've gotten the results to appear similar to our desired table. We can either manually create the table or wrangle more to get the results exactly as the table. With further wrangling, we could mutate the predictor values and rename the columns to be capitalized and then use the kable function from knitr to create the final table.


---
## Time to create some tables!

```yaml
type: "FinalSlide"
key: "ccbe649640"
```

`@script`
You now have the tools to make some tables!

