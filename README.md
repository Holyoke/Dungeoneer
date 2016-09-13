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

To run parallel  rpsec:
`bundle exec rake parallel:spec`
