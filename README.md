# HSRC

Some functions to calculate perioperative morbidity and mortality risk.

At the moment this package contains functions to calculate:

1. P-POSSUM (Portsmouth Physiological and Operative Severity Score for the enUmeration of Mortality and morbidity)
2. SRS (Surgical Risk Score)
3. SORT (Surgical Outcome Risk Tool)

The package also contains data used in the analysis in the published paper **Wong DJN, Popham S, Wilson AM, Barneto LM, Lindsay HA, Farmer L, et al**. Postoperative critical care and high-acuity care provision in the United Kingdom, Australia, and New Zealand. *British Journal of Anaesthesia*. 2019; doi: [10.1016/j.bja.2018.12.026](https://doi.org/10.1016/j.bja.2018.12.026)

The data consists of 3 data frames, and were collected from the SNAP-2: EPICCS Organisational Survey:

1. `Org_Survey_Data_Site`: The attributes of 309 hospitals in UK, Australia and New Zealand, consisting of 39 variables.
2. `Org_Survey_Data_CCU`: The attributes of 460 critical care units in UK, Australia and New Zealand, consiting of 9 variables.
3. `Org_Survey_Data_Enhanced`: The attributes of 147 high-acuity care units in UK, Australia and New Zealand, consisting of 14 variables. 

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

3. To work with data from the SNAP-2: EPICCS Organisational Survey:

```
# Find out more information about each dataset and their variables:
?Org_Survey_Data_Site
?Org_Survey_Data_CCU
?Org_Survey_Data_Enhanced

# Assign a dataset to a named dataframe:
hospitals <- Org_Survey_Data_Site
critcare <- Org_Survey_Data_CCU
enhancedcare <- Org_Survey_Data_Enhanced
```