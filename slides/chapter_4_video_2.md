---
title: Communicating cohort findings through graphs
key: d22c077f314d124f7ab5f28fa0423465

---
## Communicating cohort findings through graphs

```yaml
type: "TitleSlide"
key: "33450ca514"
```

`@lower_third`

name: Luke Johnston
title: Postdoctoral researcher in diabetes epidemiology


`@script`
Traditionally, results from cohort studies are presented as tables, but in general, tables are not as effective as figures for communicating findings.


---
## Figures should be preferred over tables

```yaml
type: "FullSlide"
key: "ec5e4806ba"
```

`@part1`
*Why?* Humans are visual, figures are visual

- Easier to interpret {{1}}
- More information per space {{1}}

*When?* {{2}}

- Units are the same/similar {{2}}
- Emphasize patterns or comparisons {{2}}
- Lots of data to show {{2}}


`@script`
When deciding how to present your results, you should first think of how to plot your data. Figures are incredibly powerful at communicating information because they leverage our reliance on our visual system. They're easier to interpret than tables and allow for greater information transmission. 

Figures are especially useful when units of measure are the same or similar, when you want to emphasize patterns or comparisons, and when there is a lot of data to show.


---
## Comparison of presentation: Figure vs table

```yaml
type: "FullSlide"
key: "a7cc464036"
center_content: true
```

`@part1`
| Predictor               |Estimate (95% CI) |
|:------------------------|:-----------------|
| body_mass_index         |2.1 (0.7, 6.4)    |
| systolic_blood_pressure |1.9 (0.8, 4.3)    |
| fasting_blood_glucose   |1.5 (0.8, 3.1)    | {{1}}

![Plot of models](https://assets.datacamp.com/production/repositories/2079/datasets/140d160b5870b6468e31abb9a971d337c4c79ceb/ch4-v2-models.png) {{2}}


`@script`
Let's use an example to illustrate the power of a figure. Here we have the estimates for three predictors from three models. Reading this table takes some time, as you need to conceptualize and compare each item.

Compare with using a plot for the same information. You quickly get a sense of the results, the magnitude, direction of association, and their comparison. You don't work as hard to understand the results. This is why we should prefer plots.

I mentioned in chapter 3 that there are many statistical techniques to analyze cohorts. Which one you'll use will dictate the plots you'll use. A common output is some type of regression-based estimate and measure of precision, like confidence intervals, which this plot shows effectively. The standard error is also another measure of precision.


---
## Plotting estimates and confidence intervals (CI)

```yaml
type: "FullSlide"
key: "efa5ebbadc"
```

`@part1`
```{r}
models %>%
    filter(model == "unadjusted") %>%
    ggplot(aes(y = predictor, x = estimate, 
               xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh() +
    geom_vline(xintercept = 1)
```
{{1}}

![Plot of estimate and 95% confidence interval.](https://assets.datacamp.com/production/repositories/2079/datasets/25486b26544f91dfece966db92fae24f0a3e0f3c/ch4-v2-estimate-ci-basic.png) {{2}}


`@script`
We can make this type of plot using geom-underscore-point, geom-underscore-errorbarh, and geom-underscore-vline. 

Each item on the y axis is a single model's predictor and associated estimate, as an odds ratio, and confidence interval. Since the null line is one for odds ratios, we need to set the x-intercept to one. When you have many model results, this plot can easily show all the models, providing a bigger overview of the findings and making it easier to compare predictors.


---
## Making the plot prettier

```yaml
type: "FullSlide"
key: "2dc9c7824c"
disable_transition: true
```

`@part1`
```{r}
models %>%
    filter(model == "unadjusted") %>%
    ggplot(aes(y = predictor, x = estimate, 
    		   xmin = conf.low, xmax = conf.high)) +
    geom_point(size = 2) +
    geom_errorbarh(height = 0.1) +
    geom_vline(xintercept = 1, linetype = "dashed") +
    theme_bw()
```
{{1}}

![(Slightly nicer) plot of estimate and 95% confidence interval.](https://assets.datacamp.com/production/repositories/2079/datasets/7bae2f71e5e1e6b0349ced75f3b5422af184c289/ch4-v2-estimate-ci-nicer.png) {{2}}


`@script`
There are couple things we could do to make the plot instantly prettier. The dot size in geom-underscore-point is a bit small so let's increase it to two using the size argument.

The errorbar ends are also a bit long. We can shorten it with the height argument of geom-underscore-errobarh. Let's shorten it to zero point one. Larger values will lead to overlap.

Let's differentiate the geom-underscore-vline by setting the linetype argument to dashed. There are many other options for linetype such as dotted or solid.

We can also change the theme. While there are several themes available, let's use theme-underscore-bw.


---
## Unadjusted and adjusted models in a single plot

```yaml
type: "FullSlide"
key: "2769fc30b4"
```

`@part1`
```{r}
models %>%
    ggplot(aes(y = predictor, x = estimate, 
               xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) +
    geom_vline(xintercept = 1, linetype = "dashed") +
    facet_grid(rows = vars(model))
```
{{1}}

![Showing both unadjusted and adjusted results](https://assets.datacamp.com/production/repositories/2079/datasets/07618ebbfd68c3d3a9c8e64fbe139b40d34e2ef4/ch4-v2-unadjusted-adjusted.png) {{2}}


`@script`
As stated in the STROBE guidelines, you need to show both unadjusted and adjusted models. Showing both on a single plot is easy if your data is properly setup. With all models in a single dataframe, you can plot the unadjusted and adjusted models by splitting them using facet-underscore-grid. Use the vars function to set the model variable. With the rows argument, the model groups will be vertically stacked instead of side by side.


---
## Got an interaction? Plot it

```yaml
type: "FullSlide"
key: "6231c20cd6"
```

`@part1`
- *Any interaction should be plotted* {{1}}
    - Simplifies interpretation
    - Should be main focus of findings
- **But**, interactions are hard {{2}}
    - Easy to model, difficult to visualize
- Found an interaction? {{3}}
    - Get specialized training or support


`@script`
Interactions are an extremely valuable source of scientific information and they need to be visualized to simplify the often difficult interpretation. 

Although modeling interactions is easy, visualizing them can be incredibly difficult and time-consuming. Visualizing interactions is heavily dependent on the modeling technique. This could be the topic of an entire course, but here we will not go into more detail. 

If your data has an interaction, get specialized training or support so you correctly visualize it.


---
## Plotting time!

```yaml
type: "FinalSlide"
key: "dced2a4c4a"
```

`@script`
Excellent, let's practice some of these skills.

