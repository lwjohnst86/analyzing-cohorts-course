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

Like all scientific studies, the design and available data restrict the type of
questions you can ask to get a valid, scientific answer. This is why before 
starting a study you need to have the research questions firmly in mind, since
you can't answer questions that the design can't answer! Now, before we get into
the type of questions we can ask, we need to cover an important concept and 
a powerful feature of cohorts, especially prospective cohorts.

---
## Prevalent vs incident cases of disease

```yaml
type: FullImageSlide
```

`@part1`

![Prevalent vs incident cases](http://s3.amazonaws.com/assets.datacamp.com/production/repositories/2079/datasets/9b742faef2e87f693056fc5df943b18a6a85ee24/plot-prevalence-incidence.png)

`@script`

In disease epidemiology, there are two concepts. Prevalence and incidence of 
disease. Prevalence is when you take a snap shot in time and count how many people
have a disease. Incidence on the other hand is the number of new cases over a 
defined period of time. In terms of understanding how predictors influence
disease, incidence data is much more scientifically powerful than prevalence 
because there is the time component. This figure here shows what prevalence vs
incidence is in the context of a prospective cohort. There are 4 people. The 
first person has the disease at the first visit and at each later visit. The next
person has no disease but then gets the disease at visit 1. The third person gets
the disease at the last visit. Lastly, the fourth person never gets the disease.
The prevalence of disease depends on the visit time you look at. In visit 0,
there is only 1 prevalent case, while at visit 3 there are 3 prevalent cases.
Incidence on the other hand is the number of new cases from start to end. In this
case, only persons 2 and 3 got a disease during the study, so there are only 2
incident cases. Determining incident cases is dependent on the person's previous
status and so is a bit more difficult to count compared to prevalence. But it is
this incidence cases that give prospective cohorts more scientific power for 
finding evidence of risk for exposures.

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

With the prevalence vs incidence in mind, we can see that some questions can't
be asked of retrospective cohorts. But there are several other restrictions to
consider when thinking of questions answerable from cohort designs. For one,
because cohorts are observational studies, questions on causes are difficult, if
not impossible, to answer. Questions that include people outside the scope of the
cohort can't be answered. For instance, if the cohort is only older adults, you
can't ask questions about young children using this data. More realistically,
and also very common, if the cohort is made up of mostly people of European
ancestry, you can't apply the answers to your questions to other ethnic groups or
ancestries. When it comes to the prospective cohorts specifically, because of the time
component, we can answer questions that include some temporal aspect as well as
answer questions about risk in unexposed vs exposed.

---
## Let's practice!

```yaml
type: FinalSlide
key: 91e2c39791
```

`@script`

Alright, let's get to doing some more exploring of the data!
