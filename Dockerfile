FROM rocker/r-ver:4.3.3

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libsodium-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    pkg-config \
    build-essential \
    gfortran \
    cmake \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages(c('plumber','jsonlite','dplyr','data.table','DT','future','promises','httr','curl','openssl','logger','uuid','lubridate','Rcpp','stringr','glue','tibble','purrr','fastmap','httpuv','webutils','sodium'), repos='https://cloud.r-project.org')"

WORKDIR /app

COPY . /app

EXPOSE 8000

CMD ["R", "-e", "pr <- plumber::plumb('api.R'); pr$run(host='0.0.0.0', port=as.numeric(Sys.getenv('PORT', 8000)))"]
