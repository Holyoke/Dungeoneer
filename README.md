# JobWalk

JobWalk is an application for project engineers to help manage their floor plans with 360 photos.

# Technologies Used:

This is a `Rails 5` application.

The app is utilizing `Devise` for User authentication.

For Image Uploading and Processing, JobWalk is utilizing `CarrierWave` and `MiniMagick`.

For interactive maps, Web App is looking to use `leaflet.js`.

For production, `Heroku` and `AWS` will be used.

Dev notes:

To setup parallel rspec:
`bundle exec rake parallel:setup`

To run parallel rpsec:
`bundle exec rake parallel:spec`

Enviroment variables:

`RAILS_ENV`: webpack watches this enviroment variable to decide whether to look
at changes in code and rebuild bundle.js

React setup:
`cd frontend && npm install`

Making changes to frontend of react:
`cd frontend && node webpack_config.js`

Setup everything:

`bundle install && bundle exec rake db:create && bundle exec rake db:migrate  &&
cd frontend && npm install`
