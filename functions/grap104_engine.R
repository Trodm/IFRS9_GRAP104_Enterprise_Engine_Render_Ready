generate_grap104_journal <- function(opening_ecl, closing_ecl) {
  movement <- closing_ecl - opening_ecl

  if (movement > 0) {
    entry <- data.frame(
      debit = "Impairment Loss - Statement of Financial Performance",
      credit = "Loss Allowance - Financial Assets",
      amount = movement,
      movement_type = "Increase in impairment allowance"
    )
  } else if (movement < 0) {
    entry <- data.frame(
      debit = "Loss Allowance - Financial Assets",
      credit = "Impairment Reversal - Statement of Financial Performance",
      amount = abs(movement),
      movement_type = "Decrease in impairment allowance"
    )
  } else {
    entry <- data.frame(
      debit = "No journal required",
      credit = "No journal required",
      amount = 0,
      movement_type = "No movement"
    )
  }

  entry
}
