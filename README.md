# Job Listing SMS Notifier

This R script automates the process of staying updated on job opportunities by retrieving, filtering, and notifying about relevant job listings via SMS.

## Features

- **API Integration**: Fetches job postings from the Handshake API.
- **Keyword Filtering**: Filters job listings based on user-defined keywords (e.g., "Analyst").
- **SMS Notification**: Sends concise SMS notifications using the TextBelt API.
- **Customizable**: Easily adaptable to different job search criteria and notification preferences.

## Usage

1. Ensure R and required libraries (httr, jsonlite, dplyr) are installed.
2. Set up TextBelt API key.
3. Customize keyword and number of listings in `getListings()` function.
4. Run the script to receive SMS notifications for relevant job listings.

### Implementing with CRON

You can use CRON to schedule the execution of the R script at regular intervals. Follow these steps to set up a periodic job:

1. Open your terminal or command prompt.

2. Type `crontab -e` and press Enter to open the CRON table for editing.

3. Add a new line to schedule the execution of your R script. For example, to run the script every hour, add the following line:

0 * * * * Rscript /path/to/your/script.R


Replace `/path/to/your/script.R` with the actual path to your R script.

4. Save and exit the editor.

Now, your R script will be executed automatically according to the schedule you specified in CRON.

## Dependencies

- **R Packages**: httr, jsonlite, dplyr
- **APIs**: Handshake, TextBelt

## Author

[Dre Dyson](https://github.com/ergosumdre)

## License

This project is licensed under the [MIT License](LICENSE).
