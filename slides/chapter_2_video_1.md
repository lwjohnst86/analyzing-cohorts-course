---
title: Exploring before wrangling
key: 146b85090bb8ab77efbfe45c5c751f5d

---
## Pre-wrangling exploration

```yaml
type: "TitleSlide"
key: "f836c98410"
```

`@lower_third`

name: Luke Johnston
title: Diabetes epidemiologist


`@script`
We've gone over some of the basics of what a cohort is and some initial explorations. In this chapter we'll get into some common wrangling tasks for cohorts and how to quickly visually explore the data.

---
## Univariate ("one variable") visualizations

```yaml
type: "TwoColumns"
key: "09f0b70d13"
```

`@part1`
```{r}
library(ggplot2)
# Histogram of body mass
ggplot(tidier_framingham,
       aes(x = body_mass_index)) +
    geom_histogram()
```
{{1}}

`@part2`
![histogram](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/299ac2253a84b199ab314633f3c771e50d2c92bb/ch2-v1-histogram.png) {{2}}


`@script`
A useful way of looking at data is to create a histogram for the univariate distribution. With ggplot2, this is easy! To set up any ggplot2 plot, we first use the ggplot function with the dataset as the first argument and the variables we want to map to the plot by using the aes function. Since we only want to see one variable, lets put bmi on the x-axis. To add a histogram layer, we plus the ggplot function with the geom-underscore-histogram function and this then shows the plot. Histograms count the number of times a specific value occurs in the data, so it a good way to get a quick overview of how the data looks. 


---
## Visualize many variables with "longer" data

```yaml
type: "FullSlide"
```

`@part1`
```{r}
library(dplyr)
wide_form <- tidier_framingham %>%
    select(subject_id,
           body_mass_index,
           participant_age)
head(wide_form, 4)
```
{{1}}

```
# A tibble: 4 x 3
  subject_id body_mass_index participant_age
       <dbl>           <dbl>           <dbl>
1       2448            27.0              39
2       2448            NA                52
3       6238            28.7              46
4       6238            29.4              52
```
{{2}}

`@script`
If we want to visualize several variables, plot one by one may take some time. But there is an easier way if we make use of the facetting feature of ggplot2. We'll go over it more shortly, but to make use of facetting, we'll need our data in the long form.

Our data right now is currently in a wider format. Let's take a look at it by selecting a few variables. This wider data has variables as columns and the values that make up the cells of those columns.

---
## Convert to "longer" form using gather

```yaml
type: "FullSlide"
```

`@part1`
```{r}
library(tidyr)
long_form <- wide_form %>%
    head(4) %>%
    gather(variable, value, -subject_id)
long_form
```
{{1}}

```
# A tibble: 8 x 3
  subject_id variable        value
       <dbl> <chr>           <dbl>
1       2448 body_mass_index  27.0
2       2448 body_mass_index  NA  
3       6238 body_mass_index  28.7
4       6238 body_mass_index  29.4
5       2448 participant_age  39  
6       2448 participant_age  52  
7       6238 participant_age  46  
8       6238 participant_age  52  
``` 
{{2}}

`@script`
Converting to long form is fairly easy with the gather function from tidyr. To better illustrate gather, I'll use head to convert only the first four rows. Gather takes three arguments, excluding the data argument from the pipe. The next two arguments are the names of the new columns that will contain the original variable names and the values from the original column. To keep things easy, we will call them variable and value. The next argument is the one or more variables we want to include or exclude from the gathering action. In this case, we want to exclude the subject ID.

Looking at the longer data, we see that the original columns are now stacked on top of each other in two new columns. This form of data let's us leverage the ggplot2 facetting.

---
## Visually explore multiple variables

```yaml
type: "FullSlide"
key: "1355d59abd"
```

`@part1`
```{r}
wide_form %>%
    gather(variable, value, -subject_id) %>%
    ggplot(aes(x = value)) +
    geom_histogram() +
    facet_wrap(vars(variable), scale = "free", nrow = 1)
``` 
{{1}}

![facetted histograms](http://assets.datacamp.com/production/repositories/2079/datasets/53c2a249ed4aad7c6152517a3724907195f3b499/ch2-v1-two-histograms.png) {{1}}


`@script`
So, let's try it out. We'll pipe the gathered longer data into ggplot2. This time we set x to the column with the raw data values. Then we add a histogram layer and next use the facet-underscore-wrap function. This function takes several arguments, but the first is the variables you want to facet by. The variable name needs to be wrapped with the vars function. We'll set the scale to free, since the x-axis values are different for each variable facet. To show the facets on one row we use set the nrow argument to one.

This then gives us multiple histograms on a single plot, letting us explore the data faster! This approach of converting to a longer data form can also be used for other analysis tasks, which we will cover in later chapters.

---
## Visually explore exposure by outcome

```yaml
type: "TwoColumns"
key: "b4c84874a5"
```

`@part1`
```{r}
tidier_framingham %>%
    mutate(got_cvd = as.character(got_cvd)) %>%
    ggplot(aes(x = got_cvd,
               y = body_mass_index,
               colour = got_cvd)) +
    geom_boxplot()
```
{{1}}

- `coord_flip()` for horizontal boxplots {{2}}

`@part2`
![boxplot](http://assets.datacamp.com/production/repositories/2079/datasets/9fe5658e3ae4baa93858bc040b06f075e5dd4490/ch2-v1-boxplot.png) {{1}}

`@script`
Univariate visualizations are great but since our main interest is in the disease variable, we should plot the exposures by the outcome. For categorical outcome variables like cvd, boxplots are great tools as they show the data's general distribution with the median, the twenty-fifth and seventy-fifth percentile, and a measure of slightly extreme values.

Again, with ggplot2 it's fairly easy. First, since cvd is a number of zero or one, let's force it to be categorical with mutate and as-dot-character. This time we add cvd on the x, a continuous variable like bmi on the y, and add some colour by again setting cvd. Next, add the geom-underscore-boxplot layer and we get a boxplot figure! Colors can help distinguish the two groups more easily. 

You can also use the coord-underscore-flip function to make the boxplots horizontal instead of vertical.

---
## Exploring time!

```yaml
type: "FinalSlide"
key: "6b31cf3945"
```

`@script`
Alright, let's explore the Framingham dataset some more!

