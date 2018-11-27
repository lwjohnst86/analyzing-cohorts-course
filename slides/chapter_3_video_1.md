---
title: Insert title here
key: 5ab6b9af44fc27034571fab5f10ca3ef

---
## Title Slide

```yaml
type: "TitleSlide"
key: "0d2a8f7826"
```

`@lower_third`
name: Luke Johnston
title: Instructor


`@script`

Don't go into detail too much, just "here is the code, here are the resources"
mixed effect
logistic regression

- Know how to understand and interpret the results (we'll get to knowing what
exactly is most useful to present and show for higher impact) Or move to chapter 4?


- Statistics (more of a review, expect them to know what they are doing):
    - Logistic regression
    - Mixed effects modelling
- Choice of statistic is dependent on question asked.
- In general, cohorts try to address questions such as:
    - "what type of exposures increase the risk of disease?"
    - "how much and how long do individuals need to be exposured to a risk factor
    to develop the disease?"
    - "For those that have a disease, how do they differ from those without?"
    - "Those that have more exposure over time, are they more likely to develop a disease?"
- These questions generally require some type of regression modelling in order to
estimate magnitude of association and the uncertainty around that association.

*Content*:


---
## Design type can restrict questions and analysis

```yaml
type: "TwoRows"
```

`@part1`
#### Cohorts in general

- Are observational, and can't directly find causes
- Participants have a shared characteristic - can't answer questions outside of the group


`@part2`
#### Prospective cohorts specifically

- Allow you to assess risk over a defined time, but not outside that time
- Answer questions about risk of those exposed and not exposed


`@script`
Knowing the difference between prevalence vs incidence, we can see that some questions can't be asked of retrospective cohorts since it only has prevalent cases. There are several other restrictions on questions to ask. Cohorts are observational studies, so questions on causes are difficult, or impossible, to answer. Questions about people or characteristics outside the cohort can't be answered. For instance, for a cohort of older adults, you can't ask questions about younger age groups. Or, more commonly, if the cohort is mainly those with European ancestry, you can't answer questions about other ethnic groups or ancestries. For prospective cohorts we can answer questions that include some time aspect and can also ask about risk in unexposed vs exposed.

---
## Impossible or difficult to answer questions

```yaml
type: "FullSlide"
key: "ab1164f998"
```

`@part1`
- Related to causes and effects
- Exposures that are very unreliably measured
- Inconsistently measured exposures or outcomes


`@script`
Some questions we can't ask are often obvious, such as when you don't have the data to answer your question. Other questions are more nuanced. Causes are difficult to study because of confounding, which we'll cover later. For instance, does alcohol cause cancer? This is difficult because people often do many other things when they drink, like smoke. Some data are too unreliable to use. For instance, whether vitamin D intake influences some diseases is tricky to answer because measuring diet is very hard, and measuring nutrient intake from diet is even harder. Or assume vitamin D was measured in the blood... another level to consider is that vitamin D can be measured in several ways, that each gives slightly different values. Some measurements of data are prone to error or noise, which can limit how much we trust answers to some questions.



---
## Common analyses for cohorts

```yaml
type: "FullSlide"
key: "9e89aca17a"
```

`@part1`

- For prospective and/or longitudinal:
    - *Mixed effects modeling*
    - Generalized estimating equations
    - Cox proportional hazard models

- For other types:
    - Linear regression
    - Logistic regression
    - Poisson regression

`@script`



---
## Final Slide

```yaml
type: "FinalSlide"
key: "38e4caa8be"
```

`@script`


