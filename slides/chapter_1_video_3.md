---
title: Questions and answers we can get from cohorts
key: d8b40a3d5d81b2b050f65eb79581aa42

---
## Questions and answers we can get from cohorts

```yaml
type: "TitleSlide"
key: "3363c8389e"
```

`@lower_third`

name: Luke Johnston
title: Instructor


`@script`
Like all studies, the design and available data restrict what valid scientific questions you can ask. This is why before starting a study you should have the questions firmly in mind, since the study design dictates the question. Before we get into the questions we can ask, we need to cover an important concept and powerful feature of prospective cohorts.


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
There are two terms when it comes to numbers of cases: Prevalence and incidence. Prevalence is a snap shot in time and counts how many have a disease. Incidence is the new cases of a disease over a period of time. Incidence data is much more scientifically powerful at understanding how exposures can influence disease risk because of the time component. Here shows what prevalence vs incidence is in a prospective cohort. At visit 0, there is one case, so there is one prevalent case.


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
At visit 1, there are now 2 cases, 1 of which is new. So there are two prevalent cases, but 1 incident case.


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
At visit 2, there are now 3 cases, three prevalent, one incident. Prevalence is always the number of cases at any given time point. To determine incident cases we need to know the person's previous state, so is a bit more difficult to count. In this case, there are two incident cases over the entire study period.


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
For prospective cohort analyses, it's always a good idea to check the prevalence of the disease outcomes at the first visit. It's fairly easy to do this using dplyr verbs. In this case, we are counting the number of prevalence of coronary heart disease, which is a subset of cardiovascular disease, at the first visit. One of the exclusion criteria for the Framingham study was not having cardiovascular disease. But you can see here that there are still some people who had prevalent CHD at the first visit. These things happen, even with the most rigorous practices. Part of your analysis must be to check these things beforehand.


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
Keeping in mind the prevalence vs incidence, we can see that some questions we can't ask of retrospective cohorts. There are several other restrictions to consider of answerable questions. Because cohorts are observational studies, questions on causes are difficult, if not impossible, to answer. Questions that include people outside the scope of the cohort can't be answered. For instance, if the cohort is only older adults, you can't ask questions about young children using this data. More realistically, if the cohort has mostly people of European ancestry, you can't answer questions about other ethnic groups or ancestries. For prospective cohorts, because of the time component, we can answer questions that include some temporal aspect and also answer questions about risk in unexposed vs exposed.


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
Some questions we can't ask are often obvious, such as not being able to answer questions you don't have data on. Other questions are more nuanced. Questions on causes are difficult to answer because of potential confounding, which we'll cover later on. For instance, does alcohol cause cancer? This is difficult to answer because people often do many other things when they drink, like smoking. Or some data are too unreliable to use. For instance, the question on whether vitamin D intake influences some diseases is tricky because measuring diet is very hard, and measuring nutrient intake from diet is even harder. Let's say you measured vitamin D directly in the blood to ask that question... there is another level to consider because vitamin D can be measured multiple ways, and they each give different results. So some measurements of data is prone to error or noise, which can limit our questions to ask.


---
## Let's practice!

```yaml
type: "FinalSlide"
key: "91e2c39791"
```

`@script`
Alright, let's practice!

