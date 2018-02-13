

Ideas. Do longitudinal analysis such as cox regression, relative risk, binary
and count and nominal type data. Cross sectional and linear regression. De
emphasize t tests, ANOVA etc. Nested case cohort studies.

- emphasize interpretation, meaning

Odds ratio

Chaplin curves/plots


- emphasize p-values unreliability... why is that etc etc
- what is cohort mean.. explain
- Maybe use PROMISE?


Note: maybe emph more of the disease state type of 

Use purrr to run multiple models on each dataset/groups.

- case cohort?

- The odds ratio of using  is 0.95 with a confidence interval
from 0.80 to 1.05. What is the interpretation of this 
    - MCQ, which is the wrong/right interpretation


Nested case cohort?

- debugging: log transform but interpret wrong.
    - "here's the code, here's the interpretation. What's wrong"
    - multiple choice questions, critical thinking
    - doesn't have to be something wrong with the code, or code related.

- describe a workflow for them (NOTE: emphasize this.)
    - identify research question and potential stats to use
    - check that data matches structure needed for stats (eg. long for mixed effect)
    - run model(s) and save as output
    - extract relevant/necessary info from model output
    - backtransform if necessary
    - present results as figure (preferably), maybe as table.

hardest to easiest exercise:
    - risk of disease from exposure over time, measured many times
    - time to disease based on set of exposures at a single time point
    - relative risk/odds ratio of disease for a risk factor, adjusted
        - Manually calculate RR and OR for simple example
    - run multiple models
- in all cases, need to either make a figure or a table that describes the results adequately
    - (need to get them to know how to describe the results)
    - run multiple models
    - output 

- careful with causation and interpretation of causes and effects
- principles of claiming causation in epidemiology
    - highlight that "correlation does not imply causation" problem


- course outline
    - typical workflow of analyzing cohorts, introduction to cohorts/datasets
        - talk about factors?
    - cross-sectional cohort analysis ?
    - retrospective cohort
        - exposures measured before disease (e.g. STI in youth, etc for cervical cancer)
        - use Cervical cancer dataset
    - prospective cohort
        - time to event (survival)
        - panel study
        - nested case cohort studies
