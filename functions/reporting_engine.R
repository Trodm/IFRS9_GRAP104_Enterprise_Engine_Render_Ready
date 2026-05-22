generate_management_summary <- function(ecl_result) {
  list(
    total_impairment_allowance = ecl_result$total_ECL,
    message = "IFRS 9 / GRAP 104 impairment allowance calculated successfully.",
    report_basis = "Scenario-weighted expected credit loss using PD, LGD and EAD."
  )
}
