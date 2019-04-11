---
title: Prevalence and incidence in cohorts
key: d8b40a3d5d81b2b050f65eb79581aa42

---
## Prevalence and incidence in cohorts

```yaml
type: "TitleSlide"
key: "3363c8389e"
```

`@lower_third`

name: Luke Johnston
title: Diabetes epidemiologist


`@script`
The purpose of epidemiology is to study disease. Two important terms related to diseases in cohort settings are prevalence and incidence.


---
## Prevalent vs incident cases of disease

```yaml
type: "FullImageSlide"
key: "bb42e35095"
disable_transition: true
center_content: true
```

`@part1`
![Prevalent vs incident cases](https://assets.datacamp.com/production/repositories/2079/datasets/2b4f838a060cebbdfe056971e6d3d567a2f5804a/ch1-v3-prevalence-incidence-0.png)


`@script`
What are prevalence and incidence? Prevalence is a single snapshot in time and counts the number of people who have a disease. Incidence is the number of new cases of a disease over a specific period of time. Because of the time component, incidence data is much more powerful at uncovering how exposures can influence disease. This graph illustrates prevalence compared to incidence. At visit zero, person one has a disease, so there is one total case, which is also the one prevalent case.


---
## Prevalent vs incident cases of disease

```yaml
type: "FullImageSlide"
key: "90e3cafe2e"
disable_transition: true
center_content: true
```

`@part1`
![Prevalent vs incident cases](https://assets.datacamp.com/production/repositories/2079/datasets/f69f23e9c0729d76a7890ed3edd8c5b1e9fc0367/ch1-v3-prevalence-incidence-1.png)


`@script`
At the next visit, person two develops the disease. There are now two prevalent cases, but one of these cases is an incident case.


---
## Prevalent vs incident cases of disease

```yaml
type: "FullImageSlide"
key: "58ae7c97c6"
disable_transition: true
center_content: true
```

`@part1`
![Prevalent vs incident cases](https://assets.datacamp.com/production/repositories/2079/datasets/2180510766cd89e9f8c6183e475b0ad0a0758d10/ch1-v3-prevalence-incidence-2.png)


`@script`
At visit two, person three also gets the disease. There are now three total cases, or rather three prevalent cases at visit two, and only one incident case since visit one. 

Prevalence is always the number of cases at a specific time. For incident cases though, we need to know the person's previous status, so it is more difficult to count.

Over the entire period of follow-up, there are two incident cases due to person two and person three.


---
## Incident data gives stronger scientific evidence

```yaml
type: "FullSlide"
key: "84d7194a6c"
```

`@part1`
- Temporal aspect of an association {{1}}
    - Exposure preceding disease occurrence
- Participants at recruitment *shouldn't have the disease* {{2}}
    - If they do, it isn't incident data


`@script`
It's this incidence information from prospective cohorts that is it's main strength and what makes the study design such a powerful scientific tool.

With this temporal aspect of the design and analysis, evidence for a particular finding is stronger compared to other study designs. Since the exposure occurs before the disease develops, you are able to state with more certainty whether it influenced the disease or not. 

For this to happen, participants cannot have the disease at the recruitment visit. Otherwise, it won't be incident data, as we saw in the figure. So, for prospective cohort analyses, it's important to confirm prevalent cases during the first visit.


---
## Counting number of cases at recruitment

```yaml
type: "FullSlide"
key: "3aad87343a"
```

`@part1`
```{r}
framingham %>% 
    select(prevalent_chd = prevchd,
           followup_visit_number = period) %>% 
    filter(followup_visit_number == 1) %>% 
    count(prevalent_chd)
```
{{1}}

```
# A tibble: 2 x 2
  prevalent_chd     n
          <int> <int>
1             0  4240
2             1   194
```
{{2}}

- `filter()` keeps rows matching `TRUE` logical condition {{3}}
- Drops rows with `!`, converting `TRUE` to `FALSE`, e.g. `!TRUE` equals `FALSE` {{3}}


`@script`
Let's check the number of cases at the recruitment, or first, visit. First we select and rename the variables to be more descriptive, then we use filter to keep only baseline data when visit number equals one. Next, we count the number of disease cases. Here we are counting the prevalent cases of coronary heart disease, or CHD, which is a subset of CVD. One of the exclusion criteria for the Framingham study was to not have CVD, but these participants were, likely accidentally, included in the study. 

Often during the baseline data collection, researchers find out that some participants actually do have the disease and were accidentally recruited. This happens even with the most rigorous practices, and is why exploratory data analysis is so important. Part of your analysis must be to check these things out and to confirm your assumptions. You'll also notice that we didn't use the got cvd variable. One of the reasons for this is that CVD is composed of several related diseases, such as stroke or CHD, so there are multiple variables that contain information on CVD. These are variables we will need to check into as we explore the data more and tidy it up.

Note that, in our code, filter kept the rows that match the true condition. In this case, only the first visit. But if you want to drop rows, you can do the opposite by using the exclamation mark to drop the rows that do not match the true condition.


---
## Let's practice!

```yaml
type: "FinalSlide"
key: "91e2c39791"
```

`@script`
Alright, let's practice!

