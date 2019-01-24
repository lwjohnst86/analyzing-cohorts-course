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
Sadly we can't have everything as graphs. Tables can also be effective for communicating findings.


---
## When are tables preferred?

```yaml
type: "FullSlide"
key: "2b772c0d95"
```

`@part1`
Basically, *whenever you can't use graphs*

- Units are dissimilar
- Items are distinct
- Emphasizing compact display of data
- With incomparable models
- To provide more machine-readable raw values


`@script`
When is it best to use tables? Basically, whenever you can't use a graph. For example, use a table when the units of measure are too dissimilar or when comparison between items isn't as important.


---
## Showing participant characteristics

```yaml
type: "TwoColumns"
key: "ee670c18b4"
```

`@part1`
```{r}
library(carpenter)
diet %>%
    outline_table()
``` {{1}}

```
# A tibble: 0 x 0
``` {{2}}

```{r}
diet %>%
    outline_table() %>%
    add_rows("job", stat = stat_nPct)
``` {{3}}

```
# A tibble: 4 x 2
  Variables     all        
  <chr>         <chr>      
1 job           NA         
2 - Bank worker 151 (44.8%)
3 - Conductor   84 (24.9%) 
4 - Driver      102 (30.3%)
``` {{4}}


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
``` {{5}}

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
``` {{6}}


`@script`
Presenting basic participant characteristics, as suggested by STROBE, is a great example for using a table. Here you can show summary statistics of the outcomes, the predictors, and other characteristics.

The carpenter package provides an easy way of creating these tables. To start we outline the table based on the data. With multiple time points, you could indicate the time variable so that each time point has a column. This outputs nothing right now as we haven't added rows. 

Next we add a row for the factor variable jobs. A common summary statistic for factors are count with percentage of total. So we set the stat to n percent.

Now, let's add another row for fibre using the mean and standard deviation statistic. For each row we add, it then outputs that row. Let's finish with adding more rows, but using median and interquartile range.


---
## Showing participant characteristics

```yaml
type: "FullSlide"
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
``` {{1}}

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
``` {{2}}


`@script`
Great! But the table headers aren't informative. We set them using the renaming function, with header as the argument. Then we give the names of each column. Here we want only one named column. We're basically done! Further editing is simple as this is just a data frame.


---
## Showing participant characteristics

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
Hopefully though, you use R Markdown! We can use the build table function to convert this table data into a Markdown table. You now have your basic characteristics table when presenting your cohort analysis!


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
Sometimes you may need to present your model results as a table, either as the main results output or as a supplement. Even if you present your main findings as a figure, providing the raw numerical model estimates in a machine-friendly format is helpful to other researchers who may use your findings in a meta-analysis of other cohort findings.

This table is one possible way to present your findings. A quick note, the standard error is one of the measures of precision. Ok, so how do we wrangle the results to get something like this?


---
## Wrangling model results into table format

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
``` {{1}}

```
3 (5%)
``` {{2}}


`@script`
Before we continue, we need to briefly describe a function that will really help us out. This function is glue from the glue package. Glue is really useful as you can create a character string and insert data into that string between the curly braces. Here, y in glue is replaced with 5, which will help make our results nicer.


---
## Wrangling model results into table format

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
``` {{1}}

```
# A tibble: 4 x 5
  model      predictor estimate std.error estimate_se   
  <chr>      <chr>        <dbl>     <dbl> <S3: glue>    
1 unadjusted energy        0.89      0.04 0.89 (0.04 SE)
2 unadjusted fibre         0.33      0.38 0.33 (0.38 SE)
3 adjusted   energy        0.89      0.04 0.89 (0.04 SE)
4 adjusted   fibre         0.35      0.41 0.35 (0.41 SE)
``` {{2}}


`@script`
Alright, now to wrangling the results. Most of these functions should be familiar to you since we covered them in chapter 2. The new code here is glue. We want the results to be formatted so the standard error is in brackets.

We see from the output the new column with the combined estimate and standard error.


---
## Wrangling model results into table format

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
``` {{1}}


`@script`
The next step is for the models to be the columns by using the spread function from the tidyr package. The first argument takes the model variable that groups the results and the second argument takes the estimate se variable that has the values making up the new columns. We should select only relevant columns before spreading.

Great! With minimal code we've gotten the results to appear similar to our desired table. We can either manually create the table or wrangle more to get the results exactly as the table.


---
## Time to create some tables!

```yaml
type: "FinalSlide"
key: "ccbe649640"
```

`@script`
You now have the tools to make some tables!

