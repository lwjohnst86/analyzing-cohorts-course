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
title: Instructor


`@script`
The purpose of epidemiology is to study disease. There are important terms when it comes to diseases in cohort settings: prevalence and incidence.


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
What are prevalence and incidence? We briefly covered it in the previous video, but here we will go into more detail. Prevalence is a single snapshot in time and counts how many people have a disease. Incidence is the number of new cases of a disease over a specific period of time. Because of the time component, incidence data is much more powerful at uncovering how exposures can influence disease. This graph illustrates prevalence vs incidence. At visit 0, there is one case, and so one prevalent case.


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
At visit 1, one person developed the disease, so there are now 2 prevalent cases. One of these cases is an incident case.


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
At visit 2, there are now 3 cases, three prevalent, one incident. Prevalence is always the number of cases at a given time. For incident cases, we need to know the person's previous status, so is more difficult to count. Overall, there are two incident cases over the entire followup. It's this incidence information from prospective cohorts that makes them very powerful scientific tools.


---
## Incident data gives stronger scientific evidence

```yaml
type: "FullSlide"
key: "84d7194a6c"
```

`@part1`
- Temporal aspect of an association
    - Exposure preceding disease occurrence
- Participants at recruitment *shouldn't have the disease*
    - If they do, it isn't incident data


`@script`
This is the strength of prospective cohorts, this ability to determine incident cases. It is this temporal aspect to the design and analysis that provides stronger evidence to the study findings. Because the exposure occurs before the disease develops, you can state with more certainty whether it influences the disease or not. For this to happen, participants cannot have the disease at the baseline. Otherwise, it won't be incident data, as we saw in the graph. So, for prospective cohort analyses, it's important to confirm prevalent cases at the first visit.


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

#> # A tibble: 2 x 2
#>   prevalent_chd     n
#>           <int> <int>
#> 1             0  4240
#> 2             1   194
```

- Note: `filter` keeps rows that match the `TRUE` logical condition
    - To drop rows, use the opposite
    - i.e. `!(follow_visit_number == 1)` or use `!=` instead of `==`


`@script`
Here, we're going to check the number of cases at the baseline visit. To make the variable names clearer, we rename them to be more descriptive. Next we filter to keep just the first visit data. Then we count the number of disease cases. With this code, we are counting the prevalent cases of coronary heart disease, or CHD, which is a subset of CVD. One of the exclusion criteria for the Framingham study was to not have CVD. For whatever reason, these participants got included into the study. Often during data collection at the first visit we find out some participants actually have the disease and were recruited accidentally. These things can happen, even with the most rigorous practices. That's why exploratory data analysis is so important. Part of your analysis must be to check these things out and to confirm your assumptions. You'll also notice that we didn't use the got_cvd variable. This is for several reasons which we will cover in later chapters. One of the reasons is that there are many types of CVD events, so there are multiple variables that contain that data. These are variables we will need to check into as we explore the data more and tidy it up in the process.

A quick note. Filter keeps the rows that match the true condition. In this case, only the first visit. But if you want to drop, you need to do the opposite by using the exclamation mark.


---
## Let's practice!

```yaml
type: "FinalSlide"
key: "91e2c39791"
```

`@script`
Alright, let's practice some more!

