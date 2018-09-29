---
title: Introduction to cohort studies
key: fd067459a73b16863b609297f96ac32c

---
## Introduction to cohort studies

```yaml
type: "TitleSlide"
key: "0e5ec8f7ed"
```

`@lower_third`

name: Luke Johnston
title: Instructor


`@script`
Hi! I'm Luke Johnston and I work as a diabetes epidemiology researcher. In this course, we will be going over the general workflow on how to analyze cohort datasets. In this chapter, we will cover some of the basics of cohort study designs and general workflow for analyzing cohort data. We will be using the Framingham Cohort study dataset to illustrate these concepts.


---
## What is a cohort study?

```yaml
type: "TwoColumns"
key: "9039aa5cb9"
```

`@part1`
Features:
- Usually investigate risk factors for diseases
- Includes a time component 
- *Participants share common characteristic(s)*


`@part2`
![Example cohort recruitment and sample. Font Awesome Icons, using emojifonts package.](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/4f1ae5179ba09672f8f19c1a005b71d883467a2c/plot-cohort-sample.png)


`@script`
What is a cohort study? Cohorts are usually scientific studies that investigate how factors influence the risk for a disease. Cohorts always include some type of time component to the data. But most importantly, participants in a cohort all share a common characteristic hence the term "cohort". For example, in the US Nurses' Health Study, all of the participants were married female nurses.


---
## Purpose and usefulness of cohorts

```yaml
type: "TwoRowsTwoColumns"
key: "3020a2875a"
```

`@part1`
![Risk factors and health management. Font Awesome Icons, using emojifonts package.](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/c3805372fcdf0f8d07a371a2a3167578bed0a36f/plot-purpose-risk-factors.png)


`@part2`
![Informing diagnosis decisions](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/e820bcda71d9330dfe338754432df5fd316a2b7a/plot-purpose-diagnosis.png)


`@part3`
![Tracking side effects and safety from drugs](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/62af4f9f6bf1799107925f3a937b84ab945ba2f9/plot-purpose-side-effects.png)


`@part4`



`@script`
Cohort studies are fundamental to epidemiological research and a key design for answering research questions about human health and behaviour. Cohort studies are especially common in health or biomedical studies, as they can be used to identify risk factors for disease that can be targeted for prevention and for disease management strategies. They are also incredibly powerful for helping inform evidence-based clinical decisions.


---
## Two cohort study designs

```yaml
type: "TwoColumns"
key: "5a578ef6a6"
```

`@part1`
#### Prospective

Study participants:

- *Doesn't have the disease*
- Looks forward in time:
    - Multiple visits over time
    - Health and other conditions measured at time visit


`@part2`
#### Retrospective

Study participants:

- *Has the disease* 
- Looks back in time:
    - Asked about past conditions or past medical health records are examined


`@script`
There are two main types of cohort study designs, prospective and retrospective. The designs have many similarities, but it's their differences that set them apart.

Prospective cohorts are by far the most common and most powerful form of cohort design when studying how diseases develop. Retrospective cohorts on the other hand are useful for rarer diseases, where health records are easy to access, or when it is impractical or impossible to conduct a prospective cohort. The main difference between these two designs is that in the prospective cohort, participants don't have the disease at the start of the study, while for the retrospective cohort they do. We will cover these design types in more detail later.


---
## Why are the basics important to know?

```yaml
type: "FullSlide"
key: "d2a6af7c52"
```

`@part1`
- Context is vital: Cohorts study health, so has an impact on lives
- Analysis and interpretation restricted by:
    - Design type
    - What was measured and how
- Examples: 
    - Data with noise often in retrospective cohorts - be cautious
    - Exposure is physiological abstraction - should transform


`@script`
Sometimes there is a pressure or urge to just "throw variables into the model and let the data tell the story". But this can be very dangerous, especially when it comes to studies on health. Because cohort studies often involve some disease, the results can have a real-world impact on people's lives. As the researcher, you need to know what data you are dealing with and how it was collected in order to appropriately analyze and interpret the results. You need to know the context of the data, which is why its important to know the basics in study design.

For cohorts, the study design and types of variables measured influence how you analyze your data. For instance, retrospective cohorts tend to have imprecise measures, so you have to be very cautious about interpretation. Or there are some measures that are abstractions of a physiological process, so by transforming the variable you can create more meaningful and interpretable results. This also means there are many ways of analyzing cohort datasets.


---
## Framingham Heart Study

```yaml
type: "TwoRows"
key: "6fa4470529"
```

`@part1`
![Original Framingham Heart Study publication. PubMedID: PMC1525365.](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/fb4a5797d1d3f1ea761ce274b23248e606775bf0/framingham-study.png)


`@part2`
```{r}
framingham
```

```
# A tibble: 11,627 x 39
  randid   sex totchol   age sysbp diabp cursmoke cigpday   bmi diabetes
   <int> <int>   <int> <int> <dbl> <dbl>    <int>   <int> <dbl>    <int>
1   2448     1     195    39  106   70          0       0  27.0        0
2   2448     1     209    52  121   66          0       0  NA          0
3   6238     2     250    46  121   81          0       0  28.7        0
# ... with 29 more variables...
```


`@script`
We will working with the Framingham Heart Study dataset. This study started in the 1950s to investigate and establish the role of lifestyle on cardiovascular disease. Many health tips, such as being physically active, eating healthy foods, and not smoking, were first shown because of the results of this study. There are about 4400 participants, with data collected a max of 3 times over 15 years of followup, so this is great dataset to practice how to analyze cohorts.


---
## Let's do some exercises!

```yaml
type: "FinalSlide"
key: "97f61fb6b7"
```

`@script`
Alright, let's do a few exercises to review and test your cohort knowledge!

