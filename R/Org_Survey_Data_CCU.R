#' Critical Care Units identified in the SNAP-2: EPICCS Organisational Survey
#'
#' A dataset containing the attributes of 460 critical care units in UK, Australia and
#' New Zealand obtained from the SNAP-2: EPICCS Organisational Survey
#'
#' @format A data frame with 460 rows and 9 variables:
#' \describe{
#'   \item{hospitalName}{Hospital names have been replaced with a anonymised ID}
#'   \item{ccuName}{Integer, anonymised ID number for the critical care unit}
#'   \item{ccuBeds}{Total number of critical care beds in the unit}
#'   \item{ventBeds}{Total number of ventilated critical care beds in the unit}
#'   \item{ccuMix}{Factor, whether the unit is an ICU, HDU or Mixed}
#'   \item{ccuSpecialty}{Factor, whether the unit is specialist unit, can be "Cardiothoracic", "General/Mixed", "Medical", "Neurology/Neurosurgical", "Surgical", "Other"}
#'   \item{ccuAdmitOther}{Logical, if the unit is specialist unit, whether it will admit off-specialty patients}
#'   \item{country}{Factor, country where the hospital is located (England, Scotland, Wales, Northern Ireland, Australia or New Zealand)}
#'   \item{countryAgg}{Factor, country where the hospital is located, aggregated country list (UK, Australia or New Zealand)}
#'
#' }
#' @source The data originates from the Second Sprint National Anaesthesia Project:
#' EPIdemiology of Critical Care provision after Surgery (SNAP-2: EPICCS) Organisational Survey.
#'   The data was used in a paper referenced: Wong DJN, Popham S, Wilson AM, Barneto LM, Lindsay HA, Farmer L, et al. Postoperative critical care and high-acuity care provision in the United Kingdom, Australia, and New Zealand. British Journal of Anaesthesia. 2019 Feb 8
#'   \url{http://www.sciencedirect.com/science/article/pii/S000709121930011X}
"Org_Survey_Data_CCU"
