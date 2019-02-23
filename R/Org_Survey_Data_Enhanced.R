#' High-Acuity / Enhanced Care Units identified in the SNAP-2: EPICCS Organisational Survey
#'
#' A dataset containing the attributes of 147 high-acuity care units in UK, Australia and
#' New Zealand obtained from the SNAP-2: EPICCS Organisational Survey. These are units which
#' admit high-risk patients for enhanced postoperative care but are not designated as "critical
#' care" units.
#'
#' @format A data frame with 147 rows and 14 variables:
#' \describe{
#'   \item{hospitalName}{Hospital names have been replaced with a anonymised ID}
#'   \item{enhancedWardName}{Integer, anonymised ID number for the high-acuity care unit}
#'   \item{enhancedWardBeds}{Total number of beds in the high-acuity care unit}
#'   \item{enhancedNurseRatio}{Ratio of beds:nurses}
#'   \item{enhancedWardConsult}{Free-text string, specialty of responsible doctor for the unit}
#'   \item{enhancedWardTherapies}{Free-text string, types of therapy delivered on the unit}
#'   \item{continuousObs}{Logical, able to deliver continuous monitoring/observations}
#'   \item{invasiveBP}{Logical, able to deliver invasive blood pressure monitoring}
#'   \item{vasoactives}{Logical, able to deliver vasoactive infusions}
#'   \item{ventilation}{Logical, able to deliver invasive mechanical ventilation}
#'   \item{NIV}{Logical, able to deliver non-invasive ventilation/CPAP}
#'   \item{epidural}{Logical, able to manage epidural catheters/epidual infusions}
#'   \item{country}{Factor, country where the hospital is located (England, Scotland, Wales, Northern Ireland, Australia or New Zealand)}
#'   \item{countryAgg}{Factor, country where the hospital is located, aggregated country list (UK, Australia or New Zealand)}
#'
#' }
#' @source The data originates from the Second Sprint National Anaesthesia Project:
#' EPIdemiology of Critical Care provision after Surgery (SNAP-2: EPICCS) Organisational Survey.
#'   The data was used in a paper referenced: Wong DJN, Popham S, Wilson AM, Barneto LM, Lindsay HA, Farmer L, et al. Postoperative critical care and high-acuity care provision in the United Kingdom, Australia, and New Zealand. British Journal of Anaesthesia. 2019 Feb 8
#'   \url{http://www.sciencedirect.com/science/article/pii/S000709121930011X}
"Org_Survey_Data_Enhanced"
