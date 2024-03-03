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

## Dependencies

- **R Packages**: httr, jsonlite, dplyr
- **APIs**: Handshake, TextBelt

## Author

[Dre Dyson](https://github.com/ergosumdre)

## License

This project is licensed under the [MIT License](LICENSE).
