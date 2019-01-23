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


---
## When are tables preferred?

```yaml
type: "FullSlide"
```

`@part1`

*Really, whenever you can't use graphs*

- Units are dissimilar
- Items are distinct
- Emphasizing compact display of data
- With incomparable models
- To provide more machine-readable raw values

`@script`


Disparate estimates from models or results (e.g. showing results from full 
model, that includes both discrete and continuous exposures)
(though arguably the data for the figure should be provided with the
figure) This is especially important for meta-analyses done on the topic of your results.

---
## Examples of effective tables

```yaml
type: "FullSlide"
```

`@part1`



`@script`


---
## Showing participant characteristics

```yaml
type: "TwoColumns"
```

`@part1`

```{r}
library(carpenter)
diet %>%
    outline_table()
```

```
# A tibble: 0 x 0
```

```{r}
diet %>%
    outline_table() %>%
    add_rows("job", stat = stat_nPct)
```

```
# A tibble: 4 x 2
  Variables     all        
  <chr>         <chr>      
1 job           NA         
2 - Bank worker 151 (44.8%)
3 - Conductor   84 (24.9%) 
4 - Driver      102 (30.3%)
```

`@part2`

```{r}
diet %>%
    outline_table() %>%
    add_rows("job", stat = stat_nPct) %>%
    add_rows("fibre", stat = stat_meanSD) %>%
    add_rows(c("energy", "weight"), 
             stat = stat_medianIQR)
```

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

`@script`

Showing the basic participant characteristics is a valuable source of information and is stated in the STROBE guidelines. A table is an excellent form to present this data, as you can show summary statistics of the outcomes, the predictors, and other characteristics. For prospective cohorts, a column can be included for each time point. 

The carpenter package provides an easy way of creating these tables. Using the diet dataset, let's start creating this table. First we outline the table. If you have multiple time points, this is where you indicate the column that has the time data in it. You see nothing is given when outlining the table, since we haven't added rows yet. 

Let's add a row for jobs. Since job is a factor variable, the most common summary is number with percent of total. We need to set the stat to n percent to generate this statistic.

There are several other summary statistics to use, but you can only calculate a single statistic for each row. Let's add another row for fibre and show the mean and standard deviation. Cool, each time we add a row, it outputs that row. Alright, let's add some more rows, but with median and interquartile range. Pretty simple eh!

---
## Showing participant characteristics

```yaml
type: "TwoColumns"
```

`@part1`

```{r}
basic_char_table <- diet %>%
    outline_table() %>%
    add_rows("job", stat = stat_nPct) %>%
    add_rows("fibre", stat = stat_meanSD) %>%
    add_rows(c("energy", "weight"), 
             stat = stat_medianIQR) %>%
    renaming("header", c("", "Characteristics"))
basic_char_table
```

`@part2`

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

`@script`

Ok, but the table headers aren't the best. We can set them with the renaming function and using header as the argument. Then we type out the names of the columns. Here we'll only have one column named. Great, this is basically done. If you want to export this to a csv file for more editting, you can do that easily as this is just a data frame.

---
## Showing participant characteristics

```yaml
type: "FullSlide"
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

Hopefully though, you use R Markdown! Here we can use the build table function to convert this table data into a Markdown table. You now have your basic characteristics table when presenting your cohort analysis.

---
## Wrangling model results into table format

```yaml
type: "FullSlide"
```

`@part1`

**Example table showing model estimates and standard errors**: {{1}}

|           |Unadjusted     |Adjusted       |
|:----------|:--------------|:--------------|
|Energy     |0.89 (0.04 SE) |0.89 (0.04 SE) |
|Fibre      |0.33 (0.38 SE) |0.35 (0.41 SE) | {{1}}

How to get this? {{2}}

`@script`

Sometimes you may need to present your model results as a table, either as the main output for the document or as a supplement. Even though you may present your main findings as a figure, providing the raw numerical values of the model in a machine-friendly format is helpful to other researchers who may use your findings in a meta-analysis of other cohort findings.

This table is one possible form you could use to present your model findings. A quick note, the standard error is one measure of precision and which the confidence interval is calculated from. Ok, so how do we wrangle the model results to get something like this?

---
## Wrangling model results into table format

```yaml
type: "FullSlide"
```

`@part1`

```{r}
x <- 3
y <- 5
glue("{x} ({y}%)")
```

```
3 (5%)
```

```{r}
models
```

```
# A tibble: 4 x 9
  term  estimate std.error statistic p.value conf.low
  <chr>    <dbl>     <dbl>     <dbl>   <dbl>    <dbl>
1 ener…    0.887    0.0404     -2.97 0.00297    0.817
2 fibre    0.326    0.382      -2.94 0.00328    0.149
3 ener…    0.892    0.0420     -2.71 0.00666    0.820
4 fibre    0.346    0.412      -2.58 0.0100     0.149
# … with 3 more variables: conf.high <dbl>,
#   predictor <chr>, model <chr>
```

`@script`

Before we get into the wrangling, we'll need to take a quick detour to describe a function that will really help us out. This function is called glue from the glue package. Glue is really useful as you can create a character string however you desire and insert data into that string between the curly braces. So here, the five is included between the brackets... {{complete}}

---
## Wrangling model results into table format

```yaml
type: "FullSlide"
```

`@part1`

```{r}
models %>%
    select(model, predictor, estimate, std.error) %>%
    mutate_at(vars(estimate, std.error), round, digits = 2) %>%
    mutate(estimate_se = glue("{estimate} ({std.error} SE)"))
```

```
# A tibble: 4 x 5
  model      predictor estimate std.error estimate_se   
  <chr>      <chr>        <dbl>     <dbl> <S3: glue>    
1 unadjusted energy        0.89      0.04 0.89 (0.04 SE)
2 unadjusted fibre         0.33      0.38 0.33 (0.38 SE)
3 adjusted   energy        0.89      0.04 0.89 (0.04 SE)
4 adjusted   fibre         0.35      0.41 0.35 (0.41 SE)
```

`@script`


---
## Wrangling model results into table format

```yaml
type: "FullSlide"
```

`@part1`

```{r}
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

`@script`

Notice how the p-value is not included here. When trying to communicate results
that can have health impacts, its important to focus on the important parts ... 
the magnitude and general precision of the association, which is more informative to clinicians and public health practitioners.



---
## Final Slide

```yaml
type: "FinalSlide"
key: "ccbe649640"
```

`@script`


