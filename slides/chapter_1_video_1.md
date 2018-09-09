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
Hi! I'm Luke Johnston and I am a diabetes epidemiology researcher. I will be your instructor for this course, where we will be going over how to analyze cohort datasets. In this chapter, we will cover some of the basics of a cohort, the process of analyzing cohort datasets, first steps in analysis, and briefly look at the Framingham Cohort study.


---
## What is a cohort study?

```yaml
type: "TwoColumns"
key: "9039aa5cb9"
```

`@part1`
Features:
- Usually studies associations with disease
- Data includes some time component 
- *Participants share common characteristic(s)*


`@part2`
![Example cohort recruitment and sample. Font Awesome Icons, using emojifonts package.](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/4f1ae5179ba09672f8f19c1a005b71d883467a2c/plot-cohort-sample.png)


`@script`
What is a cohort study? Cohorts are usually scientific studies to investigate how factors influence the risk for a disease. Cohorts always include a time component, or a temporal aspect. Most importantly, participants in a cohort share a common characteristic. For instance, in the Nurses' Health Study from the United States, all participants are married female nurses. In this course, we aren't going to cover specific statistical techniques because cohort analysis is so diverse. Instead, we are going to focus on the overall workflow and process of looking at, analyzing, interpreting, and presenting results from cohorts.


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
Cohort studies are fundamental to epidemiological research and a key design for answering research questions about human health and behavior. Cohort studies are especially common in health studies, as they can be used to identify risk factors for disease that can be targeted in prevention and disease management strategies. They are also incredibly powerful for helping inform evidence-based clinical decisions.


---
## Two cohort study designs

```yaml
type: "TwoColumns"
key: "5a578ef6a6"
```

`@part1`
#### Prospective

Study participants:

- Don't have the disease
- Looks forward in time:
    - Multiple visits over time
    - Health and other conditions measured at time visit
- Comparison group is those without the disease


`@part2`
#### Retrospective

Study participants:

- Have the disease
- Looks back in time:
    - Asked about past conditions or past medical health records are examined
- Needs a comparison group without the disease


`@script`
We will briefly discuss the basics of cohort study designs in this lesson and cover them in more detail later. There are two cohort study designs, prospective and retrospective. The designs have many similarities, but it is their differences that really set them apart.

Prospective cohorts are by far the most common and most powerful form of cohort for studying disease states, especially for diseases that are common, like diabetes. Retrospective cohorts are useful with rarer diseases, where health records are easy to access, or when it is impractical or impossible to conduct a prospective cohort.


---
## Why the basics are important to know

```yaml
type: "FullSlide"
key: "d2a6af7c52"
```

`@part1`
Why not just analyze the data? Why need to know the basics of cohorts?

- Type of cohort design restricts type of analysis and interpretation
    - Example: Retrospective cohorts often already have measured collected that are less detailed, so need to be very general and cautious in interpretation
- How and what variables were measured limit analysis and interpretation
    - Example: Some exposures/predictors are abstractions of underlying physiology, so need to transform variables so results are meaningful


`@script`
Sometimes there is a pressure or urge to just "throw variables into the model and let the data tell the story". This is dangerous in many ways, especially when it comes to studies on health. Because cohort studies often involve some disease, the results can have a real-world impact on people's lives. As the researcher, you need to know what data you are dealing with and how it was collected in order to appropriately analyze and interpret the results. 

In the case of cohorts, the study design and types of variables measured influence how you analyze your data. For instance, retrospective cohorts tend to have imprecise measures, so you have to be very cautious about interpretation. Or there are some measures that abstractions of a physiological process, so by transforming the variable you can have meaningful results. This also means there are many ways of analyzing cohort datasets.


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
Now we get to the Framingham study, which started in the 1950s to investigate and establish the role of lifestyle on cardiovascular disease. Many health tips, such as being physically active, eating healthy foods, and not smoking, were first shown from the results of this study. The study has about 4400 participants, with data collected about 3 times over 15 years of followup.  

There are things that aren't very clean in the dataset. For instance, the variable names aren't clear and some values don't tell us their meaning, such as the values in sex. What does 2 mean? We'll need to do some tidying beforehand. Before that, it's a good idea to explore the data to understand it.


---
## Let's do some exercises!

```yaml
type: "FinalSlide"
key: "97f61fb6b7"
```

`@script`
Let's do a few exercises to review and test your cohort knowledge!

