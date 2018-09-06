---
title: Questions and answers we can get from cohorts
key: d8b40a3d5d81b2b050f65eb79581aa42


---
## Questions and answers we can get from cohorts

```yaml
type: TitleSlide
key: 3363c8389e
```

`@lower_third`
name: Luke Johnston
title: Instructor

`@script`

Like all studies, the design and available data restrict what valid scientific questions you can ask. This is why before starting a study you should have the questions firmly in mind, since the study design dictates the question. Before we get into the questions we can ask, we need to cover an important concept and powerful feature of prospective cohorts.

---
## Prevalent vs incident cases of disease

```yaml
type: FullImageSlide
```

`@part1`

![Prevalent vs incident cases](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/9b742faef2e87f693056fc5df943b18a6a85ee24/plot-prevalence-incidence.png)

`@script`

In disease epidemiology, there are two concepts. Prevalence and incidence. Prevalence is when you take a snap shot in time and count how many people have a disease. Incidence is the number of new cases over a defined period of time. For understanding how exposures influence disease, incidence data is much more powerful because of the time component. This figure here shows what prevalence vs incidence is in a prospective cohort. There are 4 people. At visit 0, there is one case, so there is one prevalent case. At visit 1, there are 2 cases and 1 is new, so two prevalent cases, but only one incident case. At visit 2, there are 3 cases, three prevalent, one incident. As you can see, determining incident cases requires knowing a person's previous state, so is a bit more difficult to count compared to prevalence. It is these incidence data that give prospective cohorts more scientific power when studying evidence of risk from exposures.

---
## Counting number of cases at recruitment

```yaml
type: TwoRows
```

`@part1`

```{r}
framingham %>% 
    rename(prevalent_chd = prevchd,
           followup_visit_number = period) %>% 
    filter(followup_visit_number == 1) %>% 
    count(prevalent_chd)
```

`@part2`

```{text}
# A tibble: 2 x 2
  prevalent_chd     n
          <int> <int>
1             0  4240
2             1   194
```

`@script`

For prospective cohort analyses, it's always a good idea to check the prevalence of the disease outcomes at the first visit. It's fairly easy to do this using dplyr verbs. In this case, we are counting the number of prevalence of coronary heart disease, which is a subset of cardiovascular disease, at the first visit. One of the exclusion criteria for the Framingham study was not having cardiovascular disease. But you can see here that there are still some people who had prevalent CHD at the first visit. These things happen, even with the most rigorous practices. Part of your analysis must be to check these things before hand.

---
## Type of design restricts questions and analysis

```yaml
type: TwoRows
```

`@part1`

#### Cohorts in general

- Are observational, so can't (directly) find causes
- Shared characteristic, so can't reliably answer questions outside of group

`@part2`

#### Prospective cohorts specifically

- Allow you to assess risk over a defined time, but not outside that time
- Answer questions about risk of those exposed and not exposed

`@script`

Keeping in mind the prevalence vs incidence, we can see that some questions we can't ask of retrospective cohorts. There are several other restrictions to consider of answerable questions. Because cohorts are observational studies, questions on causes are difficult, if not impossible, to answer. Questions that include people outside the scope of the cohort can't be answered. For instance, if the cohort is only older adults, you can't ask questions about young children using this data. More realistically, if the cohort has mostly people of European ancestry, you can't answer questions about other ethnic groups or ancestries. For prospective cohorts, because of the time component, we can answer questions that include some temporal aspect and also answer questions about risk in unexposed vs exposed.

---
## Unanswerable or difficult to answer questions

```yaml
type: FullSlide
```

`@part1`

- (Most) Questions on cause.
    - Does moderate alcohol intake *cause* some types of cancer? 
- Questions involving a difficult or impossible to measure exposure.
    - How does a nutrient like Vitamin D influence disease? 
- Questions that need data that are unreliable or many be measured differently.
    - Does physical activity reduce risk of disease differently between two
    countries?
- Questions on or about very small subgroups of a population. 
    - Is there a higher risk of rare cancers in those with XXY chromosomes? 

`@script`

Some questions we can't ask are often obvious, such as not being able to answer questions you don't have data on. Other questions are more nuanced. For instance, questions on causes are difficult to answer because of potential confounding, which we'll cover in later chapters. In the example, alcohol consumption is often done with other high risk behaviours like smoking. Some data are too unreliable to use, such as the example of individual nutrient intakes and disease. Given that diet itself is very hard to measure, nutrient intake is even more difficult to reliably measure. Or some data may be measured differently between collection sites, such as the physical activity example as there are many ways to measure it. We can't rely on data that has a lot of noise or error in measurement to answer our questions. Lastly, questions on very small subgroups of a population are difficult since there often isn't enough data to use.

---
## Let's practice!

```yaml
type: FinalSlide
key: 91e2c39791
```

`@script`

Alright, let's get to doing some more exploring of the data!
