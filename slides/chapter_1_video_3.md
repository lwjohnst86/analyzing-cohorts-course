---
title: Questions and answers we can get from cohorts
key: d8b40a3d5d81b2b050f65eb79581aa42

---
## Prevalence, incidence, and what questions to ask

```yaml
type: "TitleSlide"
key: "3363c8389e"
```

`@lower_third`

name: Luke Johnston
title: Instructor


`@script`
Like all studies, the design and available data restrict what valid scientific questions you can ask. This is why before starting a study or analysis you should have the questions firmly in mind, since the study design dictates the questions. Before we get into the questions we can ask, we need to cover an important concept and a powerful feature of prospective cohorts.


---
## Prevalent vs incident cases of disease

```yaml
type: "FullImageSlide"
key: "bb42e35095"
disable_transition: true
center_content: true
```

`@part1`
![Prevalent vs incident cases](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/74be855c220692258b5b4b1eb6f1fb8d04a879a9/plot-prevalence-incidence-0.png)


`@script`
There are two terms when it comes to the numbers of disease cases: Prevalence and incidence. Prevalence is a snapshot in time and counts how many have a disease. Incidence is the new cases of a disease over a period of time. Because of the time component, incidence data is much more powerful at uncovering how exposures can influence disease. This graph illustrates prevalence vs incidence. At visit 0, there is one case, and so one prevalent case.


---
## Prevalent vs incident cases of disease

```yaml
type: "FullImageSlide"
key: "90e3cafe2e"
disable_transition: true
center_content: true
```

`@part1`
![Prevalent vs incident cases](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/12c5da3fabf7776d043cfd9a2fb588c984a1c815/plot-prevalence-incidence-1.png)


`@script`
At visit 1, there are now 2 cases, and 1 is new. So there are two prevalent cases, 1 incident case.


---
## Prevalent vs incident cases of disease

```yaml
type: "FullImageSlide"
key: "58ae7c97c6"
disable_transition: true
center_content: true
```

`@part1`
![Prevalent vs incident cases](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/428031dd7120e314d1e994b36b0147b523debb5a/plot-prevalence-incidence-2.png)


`@script`
At visit 2, there are now 3 cases, three prevalent, one incident. Prevalence is always the number of cases at a given time. For incident cases, we need to know the person's previous status, so is more difficult to count. Overall, there are two incident cases over the entire followup.


---
## Counting number of cases at recruitment

```yaml
type: "FullSlide"
key: "3aad87343a"
```

`@part1`
```{r}
framingham %>% 
    rename(prevalent_chd = prevchd,
           followup_visit_number = period) %>% 
    filter(followup_visit_number == 1) %>% 
    count(prevalent_chd)
```

```{text}
# A tibble: 2 x 2
  prevalent_chd     n
          <int> <int>
1             0  4240
2             1   194
```


`@script`
For prospective cohort analyses, it's good to check the prevalence of disease at the first visit. We'll do that using dplyr functions. First we filter to the first visit, then we count the disease. Here, we are counting prevalent cases of coronary heart disease, which is a subset of CVD. One of the exclusion criteria for the Framingham study was to not have CVD. But there are still some people who had prevalent CVD at the first visit. These things can happen, even with the most rigorous practices. Part of your analysis must be to check these things.


---
## Design type can restrict questions and analysis

```yaml
type: "TwoRows"
key: "dfbf7da65b"
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
## Let's practice!

```yaml
type: "FinalSlide"
key: "91e2c39791"
```

`@script`
Alright, let's practice some more!

