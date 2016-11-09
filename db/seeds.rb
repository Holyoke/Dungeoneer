# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_1 = User.create(name: "Admin1", email: "admin1@dungeoneer.com", password: "test123")
admin_2 = User.create(name: "Admin2", email: "admin2@dungeoneer.com", password: "test123")
user_jane = User.create(name: "Jane", email: "jane@dungeoneer.com", password: "test123")
user_joe = User.create(name: "Joe", email: "joe@dungeoneer.com", password: "test123")

# Add maps to admin 1
4.times do |idx|
  license = "idx#{idx}"
  map = admin_1.maps.create(
          name: "Test Map #{idx + 1}",
          description: "This is a description for Map #{idx + 1}"
          )
  admin_1.set_role(map.id, 'admin')
end

# Add users to maps in various ways
map = admin_1.maps[0]

user_joe.map_memberships.create(map: map, role: 'collaborator')
user_jane.map_memberships.create(map: map, role: 'collaborator')
admin_2.map_memberships.create(map: map, role: 'admin')

user_joe.map_memberships.create(map: admin_1.maps[1], role: 'collaborator')
user_jane.map_memberships.create(map: admin_1.maps[2], role: 'collaborator')

#Areas to map
map = admin_1.maps[0]

3.times do |n|
  map.areas.create(
      name: "Test Area #{n + 1}",
      description: "Foo",
      floor_plan: File.open(File.join(Rails.root, 'sample_data','sample_floor_plan.pdf' ))
  )
end

#Pins to area
area = map.areas.first
3.times do |n|
  area.pins.create(
      description: "Pin Seed Description #{n}",
      x: rand(),
      y: rand()
  )
end
