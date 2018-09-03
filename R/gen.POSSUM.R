#' A function to compute POSSUM scores
#'
#' This function will parse a dataframe and produce POSSUM scores to predict perioperative mortality and morbidity. To use the function, you will need to manipulate your dataframe to have columns with the structure detailed below.
#' @param x A dataframe or tbl where each row is a patient observation, and the columns are POSSUM predictor variables.
#'
#'   x must contain the following column names (not necessarily in order):
#'   \describe{
#'   \item{Age}{continuous variable, numeric or integer}
#'   \item{JVP}{binary variable, whether the patient has raised JVP or not}
#'   \item{Cardiomegaly}{binary variable, whether the patient has cardiomegaly on CXR or not}
#'   \item{Oedema}{binary variable, whether the patient has peripheral oedema or not}
#'   \item{Warfarin}{binary variable, whether the patient normally takes warfarin or not}
#'   \item{Diuretics}{binary variable, whether the patient normally takes a diuretic medication or not}
#'   \item{AntiAnginals}{binary variable, whether the patient normally takes anti-anginal medication or not}
#'   \item{Digoxin}{binary variable, whether the patient normally takes digoxin or not}
#'   \item{AntiHypertensives}{binary variable, whether the patient normally takes blood pressure meds or not}
#'   \item{Dyspnoea}{categorical variable, can be: "Non" = None; "OME" = On exertion; "L" = Limiting activities; "AR" = At rest}
#'   \item{Consolidation}{binary variable, whether the patient has consolidation on CXR}
#'   \item{PulmonaryFibrosis}{binary variable, whether the patient has a history of pulmonary fibrosis or imaging findings of fibrosis}
#'   \item{COPD}{binary variable, whether the patient has COPD or not}
#'   \item{SysBP}{continuous variable, pre-op systolic blood pressure (in mmHg)}
#'   \item{HR}{continuous variable, pre-op pulse/heart rate (in beats per min)}
#'   \item{GCS}{continuous variable, pre-op Glasgow Coma Scale (3-15)}
#'   \item{Hb}{continuous variable, pre-op Haemoglobin (in g/L), please note the units!}
#'   \item{WCC}{continuous variable, pre-op White Cell Count (in * 10^9cells/L)}
#'   \item{Ur}{continuous variable, pre-op Urea (in mmol/L)}
#'   \item{Na}{continuous variable, pre-op Sodium concentration (in mmol/L)}
#'   \item{K}{continuous variable, pre-op Potassium concentration (in mmol/L)}
#'   \item{ECG}{categorical variable, can be "ND" = Not done; "NOR" = Normal ECG; "AF6090" = AF 60-90; "AF>90" = AF>90; "QW" = Q-waves; "4E" = >4 ectopics; "ST" = ST or T wave changes; "O" = Any other abnormal rhythm}
#'   \item{OpSeverity}{categorical variable, the surgical severity, can be Min = Minor; Int = Intermediate; Maj = Major; Xma = Xmajor; Com = Complex}
#'   \item{ProcedureCount}{categorical variable, number of procedures patient underwent in the last 30 days including this one, can be "1" = 1; "2" = 2; "GT2" = >2}
#'   \item{EBL}{categorical variable, the estimated blood loss, can be "0" = 0-100ml; "101" = 101-500ml; "501" = 501-999ml; "1000" = >=1000}
#'   \item{PeritonealContamination}{categorical variable, whether there was peritoneal soiling, can be "NA" = Not applicable; "NS" = No soiling; "MS" = Minor soiling; "LP" = Local pus; "FBC" = Free bowel content pus or blood}
#'   \item{Malignancy}{categorical variable, whether the patient has malignant disease, can be "NM" = Not malignant; "PM" = Primary malignancy only; "MNM" = Malignancy + nodal metastases; "MDM" = Malignancy + distal metastases}
#'   \item{OpUrgency}{categorical variable, NCEPOD classifications of urgency, can be "Ele" = Elective; "Exp" = Expedited; "U" = Urgent; "I" = Immediate}
#'   }
#'
#' @return A dataframe (or tbl), which you can assign to an object, with the following variables:
#'   \describe{
#'   \item{PhysScore}{The physiological score for POSSUM}
#'   \item{OpScore}{The operative score for POSSUM}
#'   \item{POSSUMLogit}{The log-odds for morbidity as calculated by POSSUM}
#'   \item{pPOSSUMLogit}{The log-odds for mortatlity as calculated by pPOSSUM}
#'   }
#'
#' @section Converting to probability scale:
#'   The function will produce POSSUMLogit and pPOSSUMLogit values which are on the log-odds scale
#'   To convert to probabilities (0 to 1 scale), use \code{arm::invlogit()}. See: \code{\link[arm]{invlogit}}.
#'
#' @section References:
#'   \itemize{
#'   \item Copeland GP, Jones D, Walters M. POSSUM: A scoring system for surgical audit. Br J Surg. 1991 Mar 1;78(3):355–60. \url{http://onlinelibrary.wiley.com/doi/10.1002/bjs.1800780327/abstract}.
#'   \item Prytherch DR, Whiteley MS, Higgins B, Weaver PC, Prout WG, Powell SJ. POSSUM and Portsmouth POSSUM for predicting mortality. Br J Surg. 1998 Sep 1;85(9):1217–20. \url{http://onlinelibrary.wiley.com/doi/10.1046/j.1365-2168.1998.00840.x/abstract}
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
#'         JVP = S03ElevatedJugularVenousPressureJvp,
#'         Cardiomegaly = S03RadiologicalFindingsCardiomegaly,
#'         Oedema = S03PeripheralOedema,
#'         Warfarin = S03DrugTreatmentWarfarin,
#'         Diuretics = S03DrugTreatmentDiureticTreatment,
#'         AntiAnginals = S03DrugTreatmentAntiAnginal,
#'         Digoxin = S03DrugTreatmentDigoxinTherapy,
#'         AntiHypertensives = S03DrugTreatmentAntiHypertensive,
#'         Dyspnoea = S03Dyspnoea,
#'         Consolidation = S03RadiologicalFindingsConsolidation,
#'         PulmonaryFibrosis = S03PastMedicalHistoryPulmonaryFibrosis,
#'         COPD = S03PastMedicalHistoryCOPD,
#'         SysBP = S03SystolicBloodPressureBpAtPreAssessment,
#'         HR = S03PulseRateAtPreoperativeAssessment,
#'         GCS = S03GlasgowComaScaleGcsPreInductionOfAnaesthesia,
#'         Hb = S03Hb,
#'         WCC = S03WhiteCellCountWcc,
#'         Ur = S03Urea,
#'         Na = S03Na,
#'         K = S03K,
#'         ECG = S03EcgFindings,
#'         OpSeverity = S02PlannedProcSeverity,
#'         ProcedureCount = S04ProcedureCount,
#'         EBL = S04BloodLoss,
#'         PeritonealContamination = S04PeritonealContamination,
#'         Malignancy = S04Malignancy,
#'         OpUrgency = S02OperativeUrgency)
#' }
#'
#' test_data <- patients
#' test_output <- gen.POSSUM(test_data)
#' head(test_output)

gen.POSSUM <- function(x){

  #Compute the physiological score
  possum.df <- x %>%
    mutate(AgeCat = cut(.data$Age, breaks = c(0,60,70, Inf))) %>%
    mutate(AgeScore = ifelse(.data$AgeCat == "(0,60]", 1,
                             ifelse(.data$AgeCat == "(60,70]", 2,
                                    ifelse(.data$AgeCat == "(70,Inf]", 4, NA)))) %>%
    mutate(CardioScore = ifelse((.data$JVP %in% c("Y", "1", "TRUE") |
                                   .data$Cardiomegaly %in% c("Y", "1", "TRUE")), 8,
                                ifelse((.data$Oedema %in% c("Y", "1", "TRUE") |
                                          .data$Warfarin %in% c("Y", "1", "TRUE")), 4,
                                       ifelse((.data$Diuretics %in% c("Y", "1", "TRUE") |
                                                 .data$AntiAnginals %in% c("Y", "1", "TRUE") |
                                                 .data$Digoxin %in% c("Y", "1", "TRUE") |
                                                 .data$AntiHypertensives %in% c("Y", "1", "TRUE")), 2, 1)))) %>%
    mutate(RespScore = ifelse((.data$Dyspnoea %in% "AR" |
                                 .data$Consolidation %in% c("Y", "1", "TRUE") |
                                 .data$PulmonaryFibrosis %in% c("Y", "1", "TRUE")), 8,
                              ifelse((.data$Dyspnoea %in% "L" |
                                        .data$COPD %in% c("Y", "1", "TRUE")), 4,
                                     ifelse((.data$Dyspnoea %in% "OME"), 2, 1)))) %>%
    mutate(BPCat = cut(.data$SysBP, breaks = c(0, 89, 99, 109, 130, 170, Inf))) %>%
    mutate(BPScore = ifelse((.data$BPCat %in% "(0,89]"), 8,
                            ifelse((.data$BPCat %in% "(170,Inf]" | .data$BPCat %in% "(89,99]"), 4,
                                   ifelse((.data$BPCat %in% "(130,170]" | .data$BPCat %in% "(99,109]"), 2, 1)))) %>%
    mutate(HRCat = cut(.data$HR, breaks = c(0, 39, 49, 80, 100, 120, Inf))) %>%
    mutate(HRScore = ifelse((.data$HRCat %in% "(0,39]" | .data$HRCat %in% "(120,Inf]"), 8,
                               ifelse((.data$HRCat %in% "(100,120]"), 4,
                                      ifelse((.data$HRCat %in% "(39,49]" | .data$HRCat %in% "(80,100]"), 2, 1)))) %>%
    mutate(GCSCat = cut(.data$GCS, breaks = c(0, 8, 11, 14, Inf))) %>%
    mutate(GCSScore = ifelse((.data$GCSCat %in% "(0,8]"), 8,
                             ifelse((.data$GCSCat %in% "(8,11]"), 4,
                                    ifelse((.data$GCSCat %in% "(11,14]"), 2, 1)))) %>%
    mutate(HbCat = cut(.data$Hb, breaks = c(0, 99, 114, 129, 160, 170, 180, Inf))) %>%
    mutate(HbScore = ifelse((.data$HbCat %in% "(0,99]" | .data$HbCat %in% "(180,Inf]"), 8,
                            ifelse((.data$HbCat %in% "(99,114]" | .data$HbCat %in% "(170,180]"), 4,
                                   ifelse((.data$HbCat %in% "(114,129]" | .data$HbCat %in% "(160,170]"), 2, 1)))) %>%
    mutate(WCCCat = cut(.data$WCC, breaks = c(0, 3, 4, 10, 20, Inf))) %>%
    mutate(WCCScore = ifelse((.data$WCCCat %in% "(0,3]" | .data$WCCCat %in% "(20,Inf]"), 4,
                             ifelse((.data$GCSCat %in% "(10,20]" | .data$GCSCat %in% "(3,4]"), 2, 1))) %>%
    mutate(UrCat = cut(.data$Ur, breaks = c(0, 7.5, 10, 15, Inf))) %>%
    mutate(UrScore = ifelse((.data$UrCat %in% "(15,Inf]"), 8,
                            ifelse((.data$UrCat %in% "(10,15]"), 4,
                                   ifelse((.data$UrCat %in% "(7.5,10]"), 2, 1)))) %>%
    mutate(NaCat = cut(.data$Na, breaks = c(0, 125, 130, 135, Inf))) %>%
    mutate(NaScore = ifelse((.data$NaCat %in% "(0,125]"), 8,
                            ifelse((.data$NaCat %in% "(125,130]"), 4,
                                   ifelse((.data$NaCat %in% "(130,135]"), 2, 1)))) %>%
    mutate(KCat = cut(.data$K, breaks = c(0, 2.8, 3.1, 3.4, 5, 5.3, 5.9,  Inf))) %>%
    mutate(KScore = ifelse((.data$KCat %in% "(0,2.8]" | .data$KCat %in% "(5.9, Inf]"), 8,
                           ifelse((.data$KCat %in% "(2.8,3.1]" | .data$KCat %in% "(5.3,5.9]"), 4,
                                  ifelse((.data$KCat %in% "(3.1,3.4]" | .data$KCat %in% "(5,5.3]"), 2, 1)))) %>%
    mutate(ECGScore = ifelse((.data$ECG %in% c("AF>90", "QW", "4E", "ST", "O")), 8,
                             ifelse((.data$ECG %in% "AF6090"), 4, 1))) %>%
    mutate(PhysScore = .data$AgeScore + .data$CardioScore + .data$RespScore + .data$HRScore + .data$GCSScore + .data$HbScore + .data$WCCScore + .data$UrScore + .data$NaScore + .data$KScore + .data$ECGScore)

  #Next compute Operative score
  possum.df <- possum.df %>%
    mutate(OpSeverityScore = ifelse((.data$OpSeverity %in% c("Xma", "Com")), 8,
                                    ifelse((.data$OpSeverity %in% "Maj"), 4,
                                           ifelse((.data$OpSeverity %in% "Int"), 2, 1)))) %>%
    mutate(MultiProcedureScore = ifelse((.data$ProcedureCount %in% "GT2"), 8,
                                        ifelse((.data$ProcedureCount %in% "2"), 4, 1))) %>%
    mutate(EBLScore = ifelse((.data$EBL %in% "1000"), 8,
                             ifelse((.data$EBL %in% "501"), 4,
                                    ifelse((.data$EBL %in% "101"), 2, 1)))) %>%
    mutate(SoilingScore = ifelse((.data$PeritonealContamination %in% "FBC"), 8,
                                 ifelse((.data$PeritonealContamination %in% "LP"), 4,
                                        ifelse((.data$PeritonealContamination %in% "MS"), 2, 1)))) %>%
    mutate(MalignancyScore = ifelse((.data$Malignancy %in% "MDM"), 8,
                                    ifelse((.data$Malignancy %in% "MNM"), 4,
                                           ifelse((.data$Malignancy %in% "PM"), 2, 1)))) %>%
    mutate(UrgencyScore = ifelse((.data$OpUrgency %in% "I"), 8,
                                 ifelse((.data$OpUrgency %in% "U"), 4, 1))) %>%
    mutate(OpScore = .data$OpSeverityScore + .data$MultiProcedureScore + .data$EBLScore + .data$SoilingScore + .data$MalignancyScore + .data$UrgencyScore)

  #Now compute the POSSUM and pPOSSUM logit values
  possum.df <- possum.df %>%
    mutate(pPOSSUMLogit = -9.065 + (0.1692 * .data$PhysScore)+ (0.1550 * .data$OpScore)) %>%
    mutate(POSSUMLogit = -5.91 + (0.16 * .data$PhysScore)+ (0.19 * .data$OpScore))

  possum.df <- possum.df %>%
    select(.data$PhysScore, .data$OpScore, .data$POSSUMLogit, .data$pPOSSUMLogit)

  return(possum.df)
}
