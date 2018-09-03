#' A function to compute SORT scores
#'
#' This function will parse a dataframe and compute morbidity and mortality based on the Surgical Outcome Risk Tool (SORT). To use the function, you will need to manipulate your dataframe to have columns with the structure detailed below.
#' @param x A dataframe or tbl where each row is a patient observation, and the columns are SORT predictor variables.
#'
#'   x must contain the following column names (not necessarily in order):
#'   \describe{
#'   \item{Age}{continuous variable, numeric or integer}
#'   \item{ASA}{categorical variable, can be "I"; "II"; "III"; "IV"; "V"}
#'   \item{OpUrgency}{categorical variable, NCEPOD classifications, can be "Ele" = Elective; "Exp" = Expedited; "U" = Urgent; "I" = Immediate}
#'   \item{Specialty}{categorical variable, can be "Ortho" = Orthopaedics; "Colorectal" = Colorectal; "UpperGI" = Upper Gastrointestinal; "Vasc" = Vascular; "Bariatric" = Bariatric; "Other" = All else}
#'   \item{OpSeverity}{categorical variable, can be "Min" = Minor; "Int" = Intermediate; "Maj" = Major; "Xma" = Xmajor; "Com" = Complex}
#'   \item{Malignancy}{categorical variable, can be "NM" = Not malignant; "PM" = Primary malignancy only; "MNM" = Malignancy + nodal metastases; "MDM" = Malignancy + distal metastases; Or "Y" / "N"; Or "1" / "0"}
#'   }
#'
#' @return A dataframe (or tbl), which you can assign to an object, with the following variables:
#'   \describe{
#'   \item{SORT_mortLogit}{The log-odds for mortality as calculated by SORT}
#'   \item{SORT_morbLogit}{The log-odds for morbidity as calculated by SORT}
#'   }
#'
#' @section Converting to probability scale:
#'   The function will produce SORT_mortLogit and SORT_morbLogit values which are on the log-odds scale
#'   To convert to probabilities (0 to 1 scale), use \code{arm::invlogit()}. See: \code{\link[arm]{invlogit}}.
#'
#' @section References:
#'   \itemize{
#'   \item Protopapa KL, Simpson JC, Smith NCE, Moonesinghe SR. Development and validation of the Surgical Outcome Risk Tool (SORT). Br J Surg. 2014 Dec;101(13):1774–83. \url{http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4240514/}.
#'   \item Wong DJN, Oliver CM, Moonesinghe SR. Predicting postoperative morbidity in adult elective surgical patients using the Surgical Outcome Risk Tool (SORT). BJA: British Journal of Anaesthesia. 2017;119(1):95–105. \url{https://doi.org/10.1093/bja/aex117}
#'   }
#'
#' @import dplyr
#' @importFrom rlang .data
#'
#' @export
#'
#' @examples
#' \dontrun{
#' #Example of pre-processing to rename data variables to match expected column names
#' library(tidyverse)
#'
#' test_data <- raw_data %>%
#' select(Age = S01Age,
#'         ASA = S03AsaPsClass,
#'         OpUrgency = S02OperativeUrgency,
#'         Specialty = Specialty,
#'         OpSeverity = S02PlannedProcSeverity,
#'         Malignancy = S04Malignancy)
#' }
#'
#' test_data <- patients
#' test_output <- gen.SORT(test_data)
#' head(test_output)

gen.SORT <- function(x){

  sort.df <- x %>%
    mutate(AgeCat = cut(as.numeric(.data$Age), breaks = c(0,64,79, Inf))) %>%
    mutate(Malignancy = ifelse((.data$Malignancy %in% c("MDM", "MNM", "PM", "Y", "1")), 1, 0)) %>%
    select(.data$AgeCat, .data$ASA, .data$OpUrgency, .data$Specialty, .data$OpSeverity, .data$Malignancy) %>%
    mutate(SORT_mort = ((.data$ASA == "III") * 1.411 +
                        (.data$ASA == "IV") * 2.388 +
                        (.data$ASA == "V") * 4.081 +
                        (.data$OpUrgency == "Exp") * 1.236 +
                        (.data$OpUrgency == "U") * 1.657 +
                        (.data$OpUrgency == "I") * 2.452 +
                        (.data$Specialty %in% c("Bariatric", "Colorectal", "UpperGI", "HPB", "Thoracic", "Vascular")) * 0.712 +
                        (.data$OpSeverity %in% c("Xma", "Com")) * 0.381 +
                        (.data$Malignancy == "1") * 0.667 +
                        (.data$AgeCat == "(64,79]") * 0.777 +
                        (.data$AgeCat == "(79,Inf]") * 1.591 -
                        7.366)) %>%
    mutate(SORT_morb = ((.data$ASA == "II") * 0.332 +
                        (.data$ASA == "III") * 1.140 +
                        (.data$ASA == "IV") * 1.223 +
                        (.data$ASA == "V") * 1.223 +
                        (.data$Specialty == "Colorectal") * 1.658 +
                        (.data$Specialty == "UpperGI") * -0.929 +
                        (.data$Specialty == "Vascular") * 0.296 +
                        (.data$Specialty == "Bariatric") * -1.065 +
                        (!(.data$Specialty %in% c("Colorectal", "UpperGI", "Vascular", "Bariatric", "Ortho"))) * 0.181 +
                        (.data$OpSeverity == "Xma") * 1.238 +
                        (.data$OpSeverity == "Com") * 1.238 +
                        (.data$Malignancy == "1") * 0.897 +
                        (.data$AgeCat == "(64,79]") * 0.118 +
                        (.data$AgeCat == "(79,Inf]") * 0.550 -
                        3.228)) %>%
    select(.data$SORT_morb, .data$SORT_mort)

  return(sort.df)
}
