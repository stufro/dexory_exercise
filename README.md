# Dexory Exercise

![](demo.gif)

# Dependencies
* ruby 3.3.0
* rails 7.1.3
* PostgreSQL
* DaisyUI

# Dev Setup
```
bundle install
yarn install
rails db:create db:migrate

./bin/dev
rake api_seed # use API to load example JSON data
```

# Running tests
```
rspec
```

# Things I would consider in a production app / given more time
## Data storage & modelling
- Consider storing raw JSON data received in NoSQL DB. This could be used in the event of any data corruption or if a bug was found in the import process. It could also be easier / more performant to query high volumes of data in this way compared to in a relational DB.
- Store barcodes as a separate model to avoid brittleness of DB array and store other barcode meta data.

## Data processing
- Rather than using `report.results.create` in `ScanReportsController#create` I would write a class to save scan results individually and handle any validations for the scan result.
- I debated comparing scan and CSV input data in memory versus querying the DB for each CSV row.
- I would add _much_ more data validation to the CSV upload and JSON API endpoint

## Data presentation / UI
- Improve UX for displaying comparison report such as displaying per rack or with a more visual representation
- Use jbuilder for JSON responses in `ScanReportsController`
- Move comparison generation to separate class to avoid bloated `ComparisonReport` model

