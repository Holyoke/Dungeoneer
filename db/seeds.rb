# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_1 = User.create(name: "Admin1", email: "admin1@jobwalk.com", password: "test1234", role: 'admin')
admin_2 = User.create(name: "Admin2", email: "admin2@jobwalk.com", password: "test1234", role: 'admin')
user_joe = User.create(name: "Joe", email: "joe@jobwalk.com", password: "test1234", role: 'user')
user_jane = User.create(name: "Jane", email: "jane@jobwalk.com", password: "test1234", role: 'user')

4.times do |idx|
  license = idx % 2 == 0 ? nil : rand(100..200).to_s + ('a'..'z').to_a.sample(3).join
  byebug
  admin_1.projects.create(
          name: "Test Project #{idx + 1}",
          license: license,
          description: "This is a description for Project #{idx + 1}"
          )
end
