assign_ifrs9_stage <- function(days_past_due, rating_at_origination, current_rating) {
  rating_deterioration <- current_rating - rating_at_origination

  ifelse(
    days_past_due >= 90,
    3,
    ifelse(days_past_due >= 30 | rating_deterioration >= 2, 2, 1)
  )
}
