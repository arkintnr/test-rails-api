# README

# Requirements

1. Ruby version => 3.0.2
2. Postgresql

# Set up

1. Clone `test-rails-api` repository
2. Run `bundle install`

# DB Setup

1. Update db config in `database.yml`
2. run `rails db:setup`
3. run `rails db:seed`

# Running of Test Scripts using Rspec

1. run `rspec`

# Run the Server

1. run `rails s`

# When introducing a new payload, update the json file

1. update the field mapping in `app/assets/api/reservation_data_mapping.json`
2. example if the new payload's number of nights value refers to the key `"number_of_nights"`,
   then add the key name to the `"nights` array in the JSON file.

# Assumptions

1. A guest can only have 1 reservation
2. Based on the sample payloads, a guest already exists based on the ids `guest_id, id`,
   else a new guest will be created.
3. `total_price = payout_price + security_price`
