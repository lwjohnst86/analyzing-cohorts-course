---
title: Cohort types and introducing the dataset
key: 9e3d8b35b89128ebb91908d3aa815cf1

---
## Cohort types and introducing the dataset

```yaml
type: "TitleSlide"
key: "26a03a5d84"
```

`@lower_third`

name: Luke Johnston
title: Instructor


`@script`
Before getting more into the Framingham dataset, we're going to quickly cover more differences between the two cohort types. Since Framingham is a prospective cohort, we'll highlight why a prospective cohort was chosen over a retrospective one for this course.


---
## Comparisons between the two designs

```yaml
type: "FullSlide"
key: "583fae4d2d"
```

`@part1`
![Retrospective vs prospective cohorts. Euser et al, doi:10.1159/000235241](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/a183894d11c7317da3f4831b9e6b75cb4929942d/pro-vs-retro.png)


`@script`
There are some important differences between the two cohort types. The main difference is when the study starts relative to the outcome occurrence. In a retrospective cohort, the study starts when people have the disease and their data is collected from past records. This is very common when data is collected in a frequent or typical way, such as in a hospital, so data are already available. In prospective cohorts, people don't have a disease at the start of the study and they are followup either until the end of the study or until they get the disease. Data is collected as the time passes. Both designs have their strengths and weaknesses. If you have easy access to data already collected by a hospital or the government, retrospective cohorts are very powerful scientific tools. But, there are many strengths to prospective cohorts, which is why they tend to be common. They give stronger scientific evidence to research questions, because people are recruited without the disease. The Framingham dataset was chosen for this course because it is a prospective cohort.


---
## How a prospective cohort looks over time

```yaml
type: "FullImageSlide"
key: "b7cc4ddc54"
```

`@part1`
![Visual example of a prospective cohort](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/5008b35c45932322dbbdc87458ff4456ecaafedc/plot-prospective-outcome.png)


`@script`
Here is a typical prospective cohort. Each line is a hypothetical participant. At the study start, no one has a disease. As time passes, some people get the disease and others don't. When the study ends or at the time of analysis, there are a group of people who have the disease and usually a lot more who don't. There is also data collected at several time points over the study period. So now, you can compare how these two groups of people are different. What factors distinguish those with and without the disease? That is what we try to answer when we analyze the data.


---
## Variables of interest

```yaml
type: "FullSlide"
key: "278d9126a9"
```

`@part1`
- *Outcome*: 
    - The disease or health state (e.g. cancer)
    - Commonly shown as the $y$ in regression analysis

- *Exposure/predictor*: 
    - Variable hypothesized to relate to a disease (e.g. tobacco smoking)
    - Commonly shown as the $x$ in regression analysis


`@script`
In cohort studys, there are commonly two terms used, outcome and exposure or predictor. The term outcome is used to mean the disease and is the y variable commonly seen in statistical notation. The term exposure or predictor represents the variables that relate to or potentially influence the outcome in some way. These are the variables that we think predict getting the disease, for example, cigarette smoke and lung cancer.


---
## The prospective Framingham cohort

```yaml
type: "TwoRows"
key: "88bd3012a7"
```

`@part1`
```{r}
library(dplyr)
followup <- framingham %>%
    summarise(number_visits = max(period),
              number_years = round(max(time) / 365, 1))
knitr::kable(followup)
```

| number_visits| number_years|
|-------------:|------------:|
|             3|         13.3|


`@part2`
```{r}
initial_sample <- framingham %>% 
    filter(period == 1) %>% 
    summarise(number_participants = n())
knitr::kable(initial_sample)
```

| number_participants|
|-------------------:|
|                4434|


`@script`
Let's look at Framingham more. By using dplyr and kable from knitr, we can check and present the number of visits participants came in for and how long participants where followed for. There were 3 visits, which is from the variable period, and >13 years of follow-up, which is the variable time in days. Next, let's check how many participants came at the first visit. To only see baseline data, we filter by period. We see there are >4400 participants, which is a pretty big sample.


---
## The prospective Framingham cohort

```yaml
type: "FullSlide"
key: "fd098b73b9"
```

`@part1`
```{r}
names(framingham)
```

```
 [1] "randid"   "sex"      "totchol"  "age"      "sysbp"   
 [6] "diabp"    "cursmoke" "cigpday"  "bmi"      "diabetes"
[11] "bpmeds"   "heartrte" "glucose"  "educ"     "prevchd" 
[16] "prevap"   "prevmi"   "prevstrk" "prevhyp"  "time"    
[21] "period"   "hdlc"     "ldlc"     "death"    "angina"  
[26] "hospmi"   "mi_fchd"  "anychd"   "stroke"   "cvd"     
[31] "hyperten" "timeap"   "timemi"   "timemifc" "timechd" 
[36] "timestrk" "timecvd"  "timedth"  "timehyp" 
```

```
> unique(framingham$educ)
[1]  4  2  1  3 NA
> unique(framingham$sex)
[1] 1 2
```


`@script`
There are many things that aren't clean or obvious in the dataset. For instance, the variable names aren't clear and some values don't tell us their meaning. For instance, what does 2 mean for sex or education? We'll need to do some tidying beforehand. It's a good idea to first explore the data a bit to understand it more.


---
## Lesson summary

```yaml
type: "FullSlide"
key: "75da8bcc42"
```

`@part1`
- Design types
    - Prospective: No disease, data collected as time passes
    - Retrospective: Disease at start, data obtained from past records
- Variables of interest
    - Outcome: Is the disease 
    - Exposure/predictor: Factor that is thought to influence the outcome
- Framingham:
    - 3 visits, >13 years follow up
    - ~4400 participants


`@script`
Let's quickly review what we covered. We compared the cohort types, and differences being mostly in when the disease occurs. The terms for the variables are outcome for the disease and exposure or predictor for the variables that might relate to the outcome. Lastly, we briefly looked at the Framingham study.


---
## Let's practice and explore the dataset!

```yaml
type: "FinalSlide"
key: "ddbf9a5e1a"
```

`@script`
Ok, now, let's get to exploring the data!

