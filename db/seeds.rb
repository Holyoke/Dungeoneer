# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

4.times do |idx|
  license = idx % 2 == 0 ? nil : rand(100..200).to_s + ('a'..'z').to_a.sample(3).join
  Project.create(name: "Test Project #{idx + 1}", license: license)
end

Project.first.areas.new
