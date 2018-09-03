# HSRC

Some functions to calculate perioperative morbidity and mortality risk.

At the moment this package contains functions to calculate:

1. P-POSSUM (Portsmouth Physiological and Operative Severity Score for the enUmeration of Mortality and morbidity)
2. SRS (Surgical Risk Score)
3. SORT (Surgical Outcome Risk Tool)

---

## To install

Currently the package is not on CRAN. To install it for use within R:

1. Install the devtools package. You can do this from CRAN. Invoke R and then type

```
install.packages("devtools")
```

2. Load the devtools package, and use the `install_github()` function:

```
library(devtools)
install_github("dannyjnwong/HSRC")
```

---

## To use

1. After installing, load the package:

```
library(HSRC)
```

2. There are 3 functions `gen.POSSUM`, `gen.SORT` and `gen.SRS`. To learn more about each function type:

```
?gen.POSSUM
?gen.SORT
?gen.SRS
```