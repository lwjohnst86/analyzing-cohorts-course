---
title: Template Chapter 1
description: This is a template chapter.
---

## An exercise title written in sentence case

```yaml
type: NormalExercise
lang: r
xp: 100
skills: 1
key: 6b81b446b5
```

This is the assignment text. It should help provide students with the background information needed.
The instructions that follow should be in bullet point form with clear guidance for what is expected.

`@instructions`
- Instruction 1
- Instruction 2
- Instruction 3
- Instruction 4

`@hint`
- Here is the hint for this setup problem. 
- It should get students 50% of the way to the correct answer.
- So don't provide the answer, but don't just reiterate the instructions.
- Typically one hint per instruction is a sensible amount.

`@pre_exercise_code`

```{r}
# Load datasets and packages here.
download.file("https://assets.datacamp.com/production/repositories/2079/datasets/b0b1f5c64a8ae3de0913eff20c0ec55749b5f9f5/framingham.rda", "framingham.rda")
load("framingham.rda")
```

`@sample_code`

```{r}
# Your
# sample
# code
# should
# be
# ideally
# 10 lines or less,
# with a max
# of 16 lines.
```

`@solution`

```{r}
# Answer goes here
# Make sure to match the comments with your sample code
# to help students see the differences from solution
# to given.
# Paste here first
```

`@sct`

```{r}
# Update this to something more informative.
success_msg("Some praise! Then reinforce a learning objective from the exercise.")
```
