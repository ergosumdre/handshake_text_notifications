library("httr")
library("jsonlite")
library("dplyr")

options(scipen = 999999999)

# Function to retrieve data from API
get_api_data <- function() {
  headers <- c(
    'authority' = 'uwf.joinhandshake.com',
    'accept' = 'application/json, text/javascript, */*; q=0.01',
    'accept-language' = 'en-US,en;q=0.9',
    'cache-control' = 'no-cache',
    'cookie' = XXXXXXXX',
    'dnt' = '1',
    'pragma' = 'no-cache',
    'referer' = 'https://uwf.joinhandshake.com/stu/postings?page=1&per_page=25&sort_direction=desc&sort_column=created_at',
    'sec-ch-ua' = '"Not A(Brand";v="99", "Google Chrome";v="121", "Chromium";v="121"',
    'sec-ch-ua-mobile' = '?0',
    'sec-ch-ua-platform' = '"macOS"',
    'sec-fetch-dest' = 'empty',
    'sec-fetch-mode' = 'cors',
    'sec-fetch-site' = 'same-origin',
    'user-agent' = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36',
    'x-csrf-token' = 'XXXXXXXX==',
    'x-requested-with' = 'XMLHttpRequest'
  )
  
  currentTimeStamp <- paste0(sub("\\..*", "", paste0(as.numeric(Sys.time()) * 1000)))
  url = paste0('https://uwf.joinhandshake.com/stu/postings?category=Posting&ajax=true&including_all_facets_in_searches=true&page=1&per_page=1000&sort_direction=desc&sort_column=created_at&_=',currentTimeStamp)
  response <- GET(url,
                  add_headers(.headers=headers))
  cat("Response Status:", response$status_code, "\n")
  
  if (response$status_code == 200) {
    json_data <- content(response, as = "text") %>%
      fromJSON()
    return(json_data$results$job)
  } else {
    stop("Error: Failed to retrieve data from the API.")
  }
}
# Function to filter listings based on keyword
filter_listings <- function(df, keyword) {
  text_info <- data.frame(
    "jobName" = df$title,
    "location" = ifelse(test = df$remote == TRUE,
                        yes = "Remote",
                        no = ifelse(test = df$on_site == TRUE,
                                    yes = "On Site",
                                    no = "Hybrid")),
    "duration" = df$duration,
    "company" = df$employer_name,
    "type" = df$job_type_behavior_identifier,
    "link" = paste0("https://uwf.joinhandshake.com/stu/jobs/", df$id),
    "hasRecruiter" = ifelse(is.null(df$job_user_profiles) | lengths(df$job_user_profiles) == 0, "No Recruiter",
                            ifelse(sapply(df$job_user_profiles, function(row) any(!is.null(row))), "Recruiter", "No Recruiter"))
  )
  matchedListings <- text_info[grep(keyword, text_info$jobName, ignore.case = TRUE),]
  return(matchedListings)
}

# Function to send listings via SMS
send_listings <- function(x) {
  textBelt_url <- "https://textbelt.com/text"
  textBelt_data <- list(
    phone = '+1XXXXXXXX',
    message = paste(unlist(x), collapse = " | "),
    #message = "Test",
    key = 'API_KEY'
  )
  
  response <- POST(textBelt_url, body = textBelt_data, encode = "form")
  cat(content(response, "text"))
  if (response$status_code != 200) {
    warning("Error: Failed to send listings via SMS.")
  }
}

# Main function to execute the process
getListings <- function(keyword, n) {
  dat <- get_api_data()
  paid_listings <- dat %>% filter(salary_type_name == "Paid")
  remote_listings <- paid_listings %>% filter(remote == TRUE)
  analyst_listings <- filter_listings(remote_listings, keyword)
  analyst_listings <- analyst_listings[1:n,]
  print(analyst_listings)
  for (i in 1:nrow(analyst_listings)) {
    send_listings(analyst_listings[i, ])
    Sys.sleep(15)
  }
}

# Call the main function with the desired keyword
getListings("Analyst", 3)


