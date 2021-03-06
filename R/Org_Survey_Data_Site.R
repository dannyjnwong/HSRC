#' Hospitals participating in the SNAP-2: EPICCS Organisational Survey
#'
#' A dataset containing the attributes of 309 hospitals in UK, Australia and
#' New Zealand who responded to the SNAP-2: EPICCS Organisational Survey
#'
#' @format A data frame with 309 rows and 39 variables:
#' \describe{
#'   \item{hospitalName}{Hospital names have been replaced with a anonymised ID}
#'   \item{hospitalBeds}{Total number of beds in the hospital}
#'   \item{icu}{Logical, whether the hospital has an Intensive Care Unit}
#'   \item{hdu}{Logical, whether the hospital has a High Dependency Unit}
#'   \item{ed}{Logical, whether the hospital has an emergency department}
#'   \item{ccuBedsTot}{Total number of critical care beds in the hospital}
#'   \item{ventBedsTot}{Total number of ventilated critical care beds in the hospital}
#'   \item{tertiaryServices}{Free-text strings, raw responses from the survey indicating whether the hospital provided particular tertiary services}
#'   \item{pacu}{Logical, whether the hospital has post-anaesthesia care units or recovery area that routinely accepts ventilated patients for planned overnight recovery after surgery}
#'   \item{enhancedWard}{Logical, whether the hospital has other ward areas, i.e. "High-Acuity" beds, which receive high-risk surgical patients for enhanced perioperative care besides the ICU/HDU}
#'   \item{enhancedWardCount}{Total number of High-Acuity areas in the hospital which receive high-risk surgical patients}
#'   \item{enhancedWardBedsTot}{Total number of High-Acuity beds in the hospital}
#'   \item{genSurgTotalBeds}{Total number of inpatient surgical beds in the hospital}
#'   \item{genSurgWards}{Total number of inpatient surgical wards in the hospital}
#'   \item{genSurgAveBeds}{The number of beds in an "average" surgical ward in the hospital. Exact wording of question: 'How many beds would there be in an "average" surgical ward at your hospital? (Please give best approximation. Your hospital may have multiple surgical subspecialties. By "average" we mean a archetypical/stereotypical surgical ward, that may manage the most common inpatient surgical procedures at your hospital.)'}
#'   \item{genSurgNurseDay}{The typical number of nurses available on the "average" surgical ward per day-time shift}
#'   \item{genSurgNurseNight}{The typical number of nurses available on the "average" surgical ward per night-time shift}
#'   \item{genSurgHcaDay}{The typical number of healthcare assistants available on the "average" surgical ward per day-time shift}
#'   \item{genSurgHcaNight}{The typical number of healthcare assistants available on the "average" surgical ward per night-time shift}
#'   \item{policies}{Logical, whether the hospital has specific specific policies or pathways for particular patient subgroups}
#'   \item{policiesSpec}{Free-text strings, specialties with specific specific policies or pathways}
#'   \item{bariatrics}{Logical, whether the hospital offers tertiary bariatric surgery}
#'   \item{boneMarrowTx}{Logical, whether the hospital offers tertiary bone marrow transplantation}
#'   \item{burns}{Logical, whether the hospital offers tertiary burns care}
#'   \item{cardiothoracics}{Logical, whether the hospital offers cardiothoracic surgery}
#'   \item{complexColorectal}{Logical, whether the hospital offers tertiary complex colorectal surgery}
#'   \item{complexCardiology}{Logical, whether the hospital offers tertiary complex interventional cardiology}
#'   \item{ecmo}{Logical, whether the hospital offers extra-corporeal membrane oxygenation}
#'   \item{hpb}{Logical, whether the hospital offers tertiary hepatobiliary surgery}
#'   \item{hasu}{Logical, whether the hospital offers tertiary hyper-acute stroke services}
#'   \item{majTrauma}{Logical, whether the hospital is a designated major trauma unit}
#'   \item{maxFax}{Logical, whether the hospital offers tertiary maxillofacial surgery}
#'   \item{neurosurgery}{Logical, whether the hospital offers neurosurgery}
#'   \item{transplants}{Logical, whether the hospital offers solid-organ transplant surgery}
#'   \item{upperGI}{Logical, whether the hospital offers tertiary upper gastrointestinal surgery}
#'   \item{vascular}{Logical, whether the hospital offers tertiary vascular surgery}
#'   \item{ortho}{Logical, whether the hospital offers tertiary complex orthopaedic surgery}
#'   \item{country}{Factor, country where the hospital is located (England, Scotland, Wales, Northern Ireland, Australia or New Zealand)}
#'   \item{countryAgg}{Factor, country where the hospital is located, aggregated country list (UK, Australia or New Zealand)}
#'
#' }
#' @source The data originates from the Second Sprint National Anaesthesia Project:
#' EPIdemiology of Critical Care provision after Surgery (SNAP-2: EPICCS) Organisational Survey.
#'   The data was used in a paper referenced: Wong DJN, Popham S, Wilson AM, Barneto LM, Lindsay HA, Farmer L, et al. Postoperative critical care and high-acuity care provision in the United Kingdom, Australia, and New Zealand. British Journal of Anaesthesia. 2019 Feb 8
#'   \url{http://www.sciencedirect.com/science/article/pii/S000709121930011X}
"Org_Survey_Data_Site"
