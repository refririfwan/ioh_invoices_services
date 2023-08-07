# ioh_invoices_services

## Installation

This project was developed using ruby version 3.0.6 so it is necessary to create a development environment using rvm (ruby version manager). Make sure rvm is available following the command

rvm use 3.0.6

if it's not installed, you can install it first

rvm install 3.0.6

Next, install the required package libraries with the command

bundle install

## Formatting and Style

In helping project development to be more tidy and in accordance with writing standards and code style, this project uses the rubocop library. To check for styles, you can use the command:

rubocop app. rb

There are several configurations that are tailored to the needs of this project. The configuration can be seen in the .rubocop.yml file

## Testing

At the time of project development requires good testing so that the developed project has minimal bugs. This project has two types of tests, the first is using rspec and postman (automated test). To run the test cases that have been created, you can run them with the command

rspec spec/app_spec. rb

For postman, you can import files in the postman directory and run the collection. Select the end point that will be included in the automatic test.

## Running projects
When we want to run the project we need to run via the command

ruby app. rb

This command will run the Sinatra framework running on Puma. So that the API access details can be seen in the Puma console.

## Documentation
At this time there is no detailed documentation or swagger but for using the API you can use postman, apart from being an automated test, postman is also a manual test.
