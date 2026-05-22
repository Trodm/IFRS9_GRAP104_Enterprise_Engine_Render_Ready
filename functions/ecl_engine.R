calculate_ifrs9_grap104_ecl <- function(portfolio, scenarios) {
  required_cols <- c(
    "account_id", "days_past_due", "rating_at_origination", "current_rating",
    "EAD", "PD_12m", "PD_lifetime", "LGD", "EIR", "remaining_years"
  )

  missing_cols <- setdiff(required_cols, names(portfolio))
  if (length(missing_cols) > 0) {
    stop(paste("Missing required portfolio columns:", paste(missing_cols, collapse = ", ")))
  }

  portfolio$stage <- assign_ifrs9_stage(
    portfolio$days_past_due,
    portfolio$rating_at_origination,
    portfolio$current_rating
  )

  expanded <- merge(portfolio, scenarios)

  expanded$PD_used <- ifelse(expanded$stage == 1, expanded$PD_12m, expanded$PD_lifetime)
  expanded$adjusted_PD <- pmin(expanded$PD_used * expanded$pd_multiplier, 1)
  expanded$adjusted_LGD <- pmin(expanded$LGD * expanded$lgd_multiplier, 1)

  expanded$undiscounted_ECL <- expanded$adjusted_PD * expanded$adjusted_LGD * expanded$EAD
  expanded$discount_factor <- 1 / ((1 + expanded$EIR) ^ expanded$remaining_years)

  expanded$discounted_ECL <- ifelse(
    expanded$stage == 1,
    expanded$undiscounted_ECL,
    expanded$undiscounted_ECL * expanded$discount_factor
  )

  expanded$weighted_ECL <- expanded$discounted_ECL * expanded$weight

  account_summary <- expanded |>
    dplyr::group_by(account_id, stage, EAD) |>
    dplyr::summarise(
      IFRS9_GRAP104_ECL = sum(weighted_ECL),
      coverage_ratio = IFRS9_GRAP104_ECL / EAD,
      .groups = "drop"
    )

  stage_summary <- account_summary |>
    dplyr::group_by(stage) |>
    dplyr::summarise(
      total_EAD = sum(EAD),
      total_ECL = sum(IFRS9_GRAP104_ECL),
      coverage_ratio = total_ECL / total_EAD,
      .groups = "drop"
    )

  list(
    account_summary = account_summary,
    stage_summary = stage_summary,
    total_ECL = sum(account_summary$IFRS9_GRAP104_ECL)
  )
}
