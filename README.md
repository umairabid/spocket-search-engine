# Spocket Search Engine

Spocket screening project where we need to create a mini search engine of products

### Dependencies

* Ruby 2.6.2
* Rails 5.2.3
* Postgres 9.6

### Running the app

Directory `/data` contains the json files which can be used to bootstrap database, to setup app with your data you can add the file in this directory containing json data. The `/data` dir already contains `SpocketProducts.json`

To run application,

1. Run `bundle install`
2. Run `rails db:setup`
3. Run custom rake task `rake load_products` This will load seed the database with `SpocketProducts.json`, to seed with any other file you can run `rake load_products[$filename]`

To use application

1. Their is no explicit search trigger in the app and we listen to change event of inputs. To trigger change in input fields you will need to blur away from the input. I originally intended to trigger search while typing in input field on text change like in react but this is not how it works natively.

2. You can find the sort and filters in sidebar of the app
