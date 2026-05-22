packages <- c(
  "plumber", "jsonlite", "dplyr", "data.table", "DT",
  "future", "promises", "httr", "curl", "openssl",
  "logger", "uuid", "lubridate", "Rcpp", "stringr",
  "glue", "tibble", "purrr", "fastmap", "httpuv",
  "webutils", "sodium"
)

install.packages(packages, repos = "https://cloud.r-project.org")
