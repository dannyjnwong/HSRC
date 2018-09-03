#' A function to compute SRS scores
#'
#' This function will parse a dataframe and compute mortality based on the Surgical Risk Scale (SRS). To use the function, you will need to manipulate your dataframe to have columns with the structure detailed below.
#' @param x A dataframe or tbl where each row is a patient observation, and the columns are SRS predictor variables.
#'
#'   x must contain the following column names (not necessarily in order):
#'   \describe{
#'   \item{ASA}{categorical variable, can be "I"; "II"; "III"; "IV"; "V"}
#'   \item{OpUrgency}{categorical variable, NCEPOD classifications, can be "Ele" = Elective; "Exp" = Expedited; "U" = Urgent; "I" = Immediate}
#'   \item{OpSeverity}{categorical variable, can be "Min" = Minor; "Int" = Intermediate; "Maj" = Major; "Xma" = Xmajor; "Com" = Complex}
#'   }
#'
#' @return A dataframe (or tbl), which you can assign to an object, with the following variables:
#'   \describe{
#'   \item{SRS}{The SRS score}
#'   \item{SRS_mortLogit}{The log-odds for mortality as calculated according to the equation \eqn{SRS_mortLogit = 0.84 * SRS - 9.81}. See reference below, page 765.}
#'   }
#'
#' @section Converting to probability scale:
#'   The function will produce SRS_mort values which are on the log-odds scale
#'   To convert to probabilities (0 to 1 scale), use \code{arm::invlogit()}. See: \code{\link[arm]{invlogit}}.
#'
#' @section References:
#'   \itemize{
#'   \item Sutton R, Bann S, Brooks M, Sarin S. The surgical risk scale as an improved tool for risk-adjusted analysis in comparative surgical audit. Br J Surg. 2002 Jun 1;89(6):763–8. \url{http://onlinelibrary.wiley.com/doi/10.1046/j.1365-2168.2002.02080.x/abstract}.
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
#' select(ASA = S03AsaPsClass,
#'         OpUrgency = S02OperativeUrgency,
#'         OpSeverity = S02PlannedProcSeverity)
#' }
#'
#' test_data <- patients
#' test_output <- gen.SRS(test_data)
#' head(test_output)

gen.SRS <- function(x){

  srs.df <- x %>%
    select(.data$ASA, .data$OpUrgency, .data$OpSeverity) %>%
    mutate(SRS = (.data$ASA == "I") * 1 +
             (.data$ASA == "II") * 2 +
             (.data$ASA == "III") * 3 +
             (.data$ASA == "IV") * 4 +
             (.data$ASA == "V") * 5 +
             (.data$OpUrgency == "Ele") * 1 +
             (.data$OpUrgency == "Exp") * 2 +
             (.data$OpUrgency == "U") * 3 +
             (.data$OpUrgency == "I") * 4 +
             (.data$OpSeverity == "Min") * 1 +
             (.data$OpSeverity == "Int") * 2 +
             (.data$OpSeverity == "Maj") * 3 +
             (.data$OpSeverity == "Xma") * 4 +
             (.data$OpSeverity == "Com") * 5) %>%
    mutate(SRS_mortLogit = .data$SRS * 0.84 - 9.81) %>%
    select(.data$SRS, .data$SRS_mortLogit)

  return(srs.df)
}
