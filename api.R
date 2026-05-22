library(plumber)
library(jsonlite)
library(dplyr)

source("functions/staging_engine.R")
source("functions/ecl_engine.R")
source("functions/grap104_engine.R")
source("functions/reporting_engine.R")

#* IFRS 9 + GRAP 104 Enterprise Calculation Engine
#* @apiTitle IFRS 9 + GRAP 104 Big Data Actuarial Engine

#* Health check endpoint
#* @get /health
function() {
  list(
    status = "running",
    engine = "IFRS 9 + GRAP 104 Enterprise Actuarial Engine",
    version = "1.0.0"
  )
}

#* Example endpoint
#* @get /example
function() {
  portfolio <- data.frame(
    account_id = c("ACC001", "ACC002", "ACC003"),
    days_past_due = c(0, 45, 120),
    rating_at_origination = c(2, 3, 4),
    current_rating = c(2, 5, 7),
    EAD = c(100000, 250000, 500000),
    PD_12m = c(0.025, 0.060, 0.250),
    PD_lifetime = c(0.090, 0.280, 0.750),
    LGD = c(0.35, 0.45, 0.65),
    EIR = c(0.11, 0.12, 0.13),
    remaining_years = c(3, 5, 2)
  )

  scenarios <- data.frame(
    scenario = c("Base", "Upside", "Downside"),
    weight = c(0.60, 0.20, 0.20),
    pd_multiplier = c(1.00, 0.80, 1.50),
    lgd_multiplier = c(1.00, 0.90, 1.20)
  )

  result <- calculate_ifrs9_grap104_ecl(portfolio, scenarios)

  list(
    message = "Example IFRS 9 + GRAP 104 ECL calculation completed",
    result = result
  )
}

#* Calculate IFRS 9 / GRAP 104 ECL
#* @post /calculate_ecl
function(req, res) {
  body <- jsonlite::fromJSON(req$postBody)

  portfolio <- as.data.frame(body$portfolio)
  scenarios <- as.data.frame(body$scenarios)

  result <- calculate_ifrs9_grap104_ecl(portfolio, scenarios)

  list(
    status = "success",
    calculation = result
  )
}

#* GRAP 104 impairment journal movement
#* @post /grap104_journal
function(req, res) {
  body <- jsonlite::fromJSON(req$postBody)

  opening_ecl <- body$opening_ecl
  closing_ecl <- body$closing_ecl

  result <- generate_grap104_journal(opening_ecl, closing_ecl)

  list(
    status = "success",
    journal = result
  )
}
