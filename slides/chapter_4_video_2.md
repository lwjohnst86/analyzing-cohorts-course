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
title: Instructor


`@script`


---
## Why use figures over tables?

```yaml
type: "FullSlide"
key: "ec5e4806ba"
```

`@part1`



`@script`

STROBE, depends on statistical analysis, when and why not.

- Table or figure? When to use either
    - Above all, try to use a figure. They tend to show results the best,
    quickest, and are more intuitive/understandable then tables.
    - But not all results work in a figure.

---
## Comparison of presentation: Figure vs table

```yaml
type: "FullSlide"
```

`@part1`

|Predictor |Estimate (95% CI) |
|:---------|:-----------------|
|energy    |0.9 (0.8, 1)      |
|fibre     |0.3 (0.1, 0.7)    |
|fat       |0.8 (0.7, 0.9)    |

![Plot of models](https://assets.datacamp.com/production/repositories/2079/datasets/a3db1948e53a0be132489e15a6a60e6134d4a202/ch4-v2-models.png) {{1}}

`@script`

---
## Plotting estimates and confidence intervals

```yaml
type: "FullSlide"
```

`@part1`

```{r}
estimate_ci_plot <- models %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh() +
    geom_vline(xintercept = 1)
estimate_ci_plot
```

![Plot of estimate and 95% confidence interval.](https://assets.datacamp.com/production/repositories/2079/datasets/888f76bf313121b29a3fb1051bb4480c5ea9c3e8/ch4-v2-estimate-ci-basic.png)

`@script`

We can make this type of plot by using geom point, geom errorbar (the horizontal version), and geom vline. In this case, each item on the y axis is an individual model's predictor and on the x axis is the estimate, as odds ratios, and confidence interval from the model. Since the so called null line is at 1 for odds ratio values, we need to set the xintercept to 1. You may see that for showing many models, 

---
## Plotting estimates and confidence intervals

```yaml
type: "FullSlide"
```

`@part1`

```{r}
estimate_ci_plot_nicer <- models %>%
    ggplot(aes(y = predictor, x = estimate, xmin = conf.low, xmax = conf.high)) +
    geom_point() +
    geom_errorbarh(height = 0.2) + # Reduce width of end bars
    geom_vline(xintercept = 1, linetype = "dashed") # Line contrast with others
estimate_ci_plot
```

![(Slightly nicer) plot of estimate and 95% confidence interval.](https://assets.datacamp.com/production/repositories/2079/datasets/47f4700950e9480cd25d630861b12c9efe06d21d/ch4-v2-estimate-ci-nicer.png)

`@script`

---
## Unadjusted and adjusted models in a single plot

```yaml
type: "FullSlide"
```

`@part1`



`@script`

---
## Got an interaction? Show what it looks like!

```yaml
type: "FullSlide"
```

`@part1`



`@script`


---
## Sensitivity analysis? Show it too!

```yaml
type: "FullSlide"
```

`@part1`



`@script`

STROBE guidelines: "Report other analyses done—eg analyses of subgroups and interactions, and
    sensitivity analyses"


---
## Final Slide

```yaml
type: "FinalSlide"
key: "dced2a4c4a"
```

`@script`


