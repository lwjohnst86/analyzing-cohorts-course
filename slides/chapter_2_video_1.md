---
title: Exploring before wrangling
key: 146b85090bb8ab77efbfe45c5c751f5d

---
## Exploring before wrangling

```yaml
type: "TitleSlide"
key: "f836c98410"
```

`@lower_third`

name: Luke Johnston
title: Instructor

`@script`

Now that we've gone over some of the basics of what a cohort is and some initial explorations, in this chapter we'll get into common wrangling tasks for cohort datasets as well as for quickly visualizing the data.

---
## Visually explore individual variables

```yaml
type: "TwoColumns"
```

`@part1`

```{r}
library(ggplot2)
library(Epi)
data("diet")

ggplot(diet, aes(x = weight)) +
    geom_histogram()
``` {{1}}

`@part2`

![histogram](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/a7a52d4b64aa5f2562fdf34478a8a31912e070fa/ch2-v1-histogram.png) {{2}}


`@script`

A useful way of looking at the data is to create a histogram of the distribution. With ggplot2, this is easy! We can use the geom_histogram function. Here we are using the diet cohort dataset from the Epi package. With this code, we can plot the distribution of one variable, in this case weight. The output looks like this. We can see here that histograms count the number of values at each bin or rectangle. What if we want to look at many variables? This approach will take a while...

---
## Using long data for easier visualizing

```yaml
type: "TwoColumns"
```

`@part1`

```{r}
library(dplyr)
wide_form <- diet %>%
    head(4) %>%
    select(id, weight, 
           energy_intake = energy)
wide_form
#>    id   weight energy_intake
#> 1 102 88.17984       22.8601
#> 2  59 58.74120       23.8841
#> 3 126 49.89600       24.9537
#> 4  16 89.40456       22.2383
``` {{1}}

`@part2`

```{r}
library(tidyr)
long_form <- wide_form %>%
    gather(variable, value, -id)
long_form
#>     id      variable    value
#> 1  102        weight 88.17984
#> 2   59        weight 58.74120
#> 3  126        weight 49.89600
#> 4   16        weight 89.40456
#> 5  102 energy_intake 22.86010
#> 6   59 energy_intake 23.88410
#> 7  126 energy_intake 24.95370
#> 8   16 energy_intake 22.23830
``` {{2}}

`@script`

So instead of doing histograms one at a time, we can make use of using a different form of data and taking full advantage of ggplot2's features.  Let's take a few variables from the diet dataset. Remember that the x axis for ggplot2 took the weight values. So what if we could get all the values for weight as well as, for instance, energy intake in one column and split the plot by the two columns? This is known as the "long data format". And we can create this format very easily with the gather function from the tidyr package. The first two arguments provide the name of the two new columns, while the other arguments tell gather which variables to convert or to not convert. In this case, we are excluding id from being "gathered". With this data format we can plot multiple histograms very easily.

---
## Visually explore multiple variables

```yaml
type: "TwoColumns"
```

`@part1`

```{r}
long_form %>%
    ggplot(aes(x = value)) +
    geom_histogram() +
    # or use facet_grid
    facet_wrap(
        vars(variable),
        scale = "free",
        ncol = 1
    )
``` {{1}}

`@part2`

![facetted histograms](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/c386000b62449e65e45d4465ddc2aac280c7d167/ch2-v1-two-histograms.png) {{2}}

`@script`

Here, we combine the long data form with ggplot2's facet_wrap, by facetting on the variable column. To specify the variable, you need to wrap the variable name with the vars function. Setting scale to free allows the axis range to fit the variable's own value range. From the previous use of geom_histograms, the only difference is the data source, the x axis column, and the use of the facet_wrap. We see here that it shows multiple histograms on one single plot, which let's us explore the data faster and more efficiently! This approach is powerful not only for visualizing, but also for other exploring and analyzing tasks such as creating summary tables or running simple statistics.

---
## Visually explore exposure by outcome

```yaml
type: "TwoColumns"
```

`@part1`

```{r}
diet %>%
    ggplot(aes(x = chd, y = weight,
               colour = chd)) +
    geom_boxplot()
``` 

`@part2`

![boxplot](http://assets.datacamp.com/production/repositories/2079/datasets/8501ad0061c59bb5f1757a2ad99652fd11f70952/ch2-v1-boxplot.png) 

`@script`
Univariate visualizations are great, but don't forget that we should look at plots of exposures by outcome. For categorical outcome variables, boxplots are great tools. Here, it is fairly straight forward to put the outcome, which is coronary heart disease in this case, on the x-axis and an exposure like weight on the y-axis. Using colours help distinguish the two groups more easily.

---
## Exploring time!

```yaml
type: "FinalSlide"
key: "6b31cf3945"
```

`@script`

Alright, let's explore the Framingham dataset more!
