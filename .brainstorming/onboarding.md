# Onboarding session

1. Think about the language features and libraries your learners will use, and
the terminology they will encounter. What do you think will be most confusing or
hardest to justify? (For example, it's often hard to explain to newcomers why
Python has both lists and tuples.)

- What's the difference between relative risk and odds ratio? When to use
one over the other?
- Should adjusting for confounders be part of the main analysis or a side
analysis? (what is a covariate?) What study design requires which analysis?
- How to know what is a retrospective vs prospective analysis of a cohort
dataset.
- Which transformation to use before modelling to get a 1) better model fit
and 2) provides the most meaningful interpretation of the results.
- Is the structure of the cohort dataset important? How does the structured
dictate which analysis to use?

2. Create a multiple-choice question that tests understanding of one of the
concepts you intend to cover in your course. Include the correct answer and 2-3
incorrect answers, and explain what misconception each incorrect answer is
intended to diagnose.

- You run several regression analyses on several variables without adjusting for
confounders. You repeat these analyses adjusting for potential confounders. The
total number of models you ran is 50 and 10 of those models have 'statistically
significant associations'. What do you do with the results?
    1. Present a figure of the results of the 10 models (Incorrect: Showing only
    some of the models shows a biased view of your data and results. This is
    commonly done in many parts of science and highlights the unfortunate
    emphasis on "statistical significance")
    2. Present a figure of the results of all 50 models (Correct: You need to
    show all your analyses, regardless of the "lack of significance")
    3. Present a figure showing the most interesting and most novel result
    (Incorrect: All results are important. You may find the result you are 
    presenting the most interesting, but others may not. Like 1 above, this is 
    commonly done and highlights a focus on flashy and trendy rather than on the
    science)

3. Write a brief description of a debugging exercise you might have learners do
in your course. Include 2-3 sentences explaining what the code is supposed to do
and 5-10 lines of code that almost do that.

It is common to run multiple regression models on each outcome (y) and predictor
(x), or between two or more groups (e.g. between male and female). An efficient 
method would be to 

```{r}
library(purrr)
library(dplyr)
library(tidyr)
PROMISE.data::PROMISE %>% 
    tbl_df() %>% 
    select(Sex, BMI, Glucose0, )
    nest() %>% 
    mutate(model = map_df(data, ~ lm(Sepal.Length + )))
```

4. Create a point-form summary of what you hope to get out of developing a
course for DataCamp.

- So few courses are available at universities for graduate students to learn how
to *actually* analyze data such as from a cohort. Often concepts are taught, but 
not *how to do it*! I want to start teaching how to go about the workflow and how-to
for analyzing, interpreting, and presenting cohort data in R.
- I'd love to be able to develop this course so that I can have material to draw
from when teaching others when I teach a class.
- The model and infrastructure that DataCamp uses for course developers/instructors
is really quite nice. I want to learn from this model to hopefully develop
something similar for some research projects I have planned in diabetes
epidemiology.

-----

Notes from session:

- If you have any suggestions

- debugging: log transform but interpret wrong.
    - "here's the code, here's the interpretation. What's wrong"
    - multiple choice questions, critical thinking
    - doesn't have to be something wrong with the code, or code related.

- have previous students that have done the course come in and give a
testimonial about the course (but maybe some bias ...?)

- MCQ:
    - give MCQ before talking about why that's wrong.
    - or give it end of chapter
    - or give it at some other point (like in visualization)
        - like introduce concept it in Chapter 1, then give the MCQ in Chapter 3...
