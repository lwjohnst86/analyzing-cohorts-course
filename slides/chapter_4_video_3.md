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
Sadly we can't make all results as graphs. Tables can also be very effective at communicating meaning and results, in the right context.


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
When is best to use tables? Basically, whenever you can't use a graph. For example, use a table when the units of measure are too dissimilar or if you want your findings to be friendlier to use in meta-analyses.


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
    add_rows("job", stat = stat_nPct) %>%
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
Presenting basic participant characteristics, which is suggested by STROBE, is a great example for using a table, as it is a valuable source of information. Here you can show summary statistics of the outcomes, the predictors, and other characteristics. For prospective cohorts, a column can be included for each time point. 

The carpenter package provides an easy way of creating these tables. Using the diet dataset, let's start creating this table. First we outline the table. If you have multiple time points, this is where you indicate the column that has the time data in it. You see nothing is given when outlining the table, since we haven't added rows yet. 

Let's add a row for jobs. Since job is a factor variable, the most common summary is number with percent of total. We need to set the stat to n percent to generate this statistic.

There are several other summary statistics to use, but you can only calculate a single statistic for each row. Let's add another row for fibre and show the mean and standard deviation. Cool, each time we add a row, it outputs that row. Alright, let's add some more rows, but with median and interquartile range. Pretty simple eh!


---
## Showing participant characteristics

```yaml
type: "TwoColumns"
key: "985afd6a52"
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
``` {{1}}


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
``` {{2}}


`@script`
Ok, but the table headers aren't the best. We can set them with the renaming function and using header as the argument. Then we type out the names of the columns. Here we'll only have one column named. Great, this is basically done. If you want to export this to a csv file for more editting, you can do that easily as this is just a data frame.


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
Hopefully though, you use R Markdown! Here we can use the build table function to convert this table data into a Markdown table. You now have your basic characteristics table when presenting your cohort analysis.


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
Sometimes you may need to present your model results as a table, either as the main output for the document or as a supplement. Even though you may present your main findings as a figure, providing the raw numerical values of the model in a machine-friendly format is helpful to other researchers who may use your findings in a meta-analysis of other cohort findings.

This table is one possible form you could use to present your model findings. A quick note, the standard error is one measure of precision and which the confidence interval is calculated from. Ok, so how do we wrangle the model results to get something like this?


---
## Wrangling model results into table format

```yaml
type: "FullSlide"
key: "7a6f6ba0ae"
```

`@part1`
```{r}
x <- 3
y <- 5
glue("{x} ({y}%)")
``` {{1}}

```
3 (5%)
``` {{2}}

```{r}
models
``` {{3}}

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
``` {{4}}


`@script`
Before we get into the wrangling, we'll need to take a quick detour to describe a function that will really help us out. This function is called glue from the glue package. Glue is really useful as you can create a character string however you desire and insert data into that string between the curly braces. So here, the y in the glue string is replaced with the value 5. This will help us get the results into a nicer form.


---
## Wrangling model results into table format

```yaml
type: "FullSlide"
key: "2de3b37bbf"
```

`@part1`
```{r}
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
Alright, now to wrangling the results. Most of this could should be familiar to you already since we covered some of these commands in chapter 2. The new code here is that glue function. Here we are wanting it to be formatted so that the standard error is in the brackets.

When we output the results, we see the new column with the estimate and standard error combined together.


---
## Wrangling model results into table format

```yaml
type: "FullSlide"
key: "a685b99001"
disable_transition: true
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
``` {{1}}


`@script`
The next part is to get the code so that the models are the columns. We do that with the spread function from the tidyr package. The first argument takes the variable that has groups the rows (the model variable) and the second argument takes the values that will make up the new columns (the estimate se variable). In this case, we should select only the relevant columns before hand.

Great! With minimal code we've gotten the results to appear almost the same as our desired table. We can either now manually create the table or add more code to make the results appear exactly as the desired table.

Notice here how we don't include the p value column as a relevant column to include. Recall from the previous chapter why we shouldn't rely on p values. In this table we have everything we need, a measure of magnitude and of its precision for the associations. These are much more informative from a health outcome perspective.


---
## Time to create some tables!

```yaml
type: "FinalSlide"
key: "ccbe649640"
```

`@script`
You now have the tools to make some tables! Time to try it out.

