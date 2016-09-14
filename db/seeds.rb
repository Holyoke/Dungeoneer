# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_1 = User.create(name: "Admin1", email: "admin1@jobwalk.com", password: "test123")
admin_2 = User.create(name: "Admin2", email: "admin2@jobwalk.com", password: "test123")
user_jane = User.create(name: "Jane", email: "jane@jobwalk.com", password: "test123")
user_joe = User.create(name: "Joe", email: "joe@jobwalk.com", password: "test123")

# Add projects to admin 1
4.times do |idx|
  license = "idx#{idx}"
  project = FactoryGirl.build(:project,
          name: "Test Project #{idx + 1}",
          license: license,
          description: "This is a description for Project #{idx + 1}"
          )
  admin_1.project_memberships.create(project: project, role: 'admin')
end

# Add users to projects in various ways
project = admin_1.projects[0]

user_joe.project_memberships.create(project: project, role: 'collaborator')
user_jane.project_memberships.create(project: project, role: 'collaborator')
admin_2.project_memberships.create(project: project, role: 'admin')

user_joe.project_memberships.create(project: admin_1.projects[1], role: 'collaborator')
user_jane.project_memberships.create(project: admin_1.projects[2], role: 'collaborator')

#Areas to project
project = admin_1.projects[0]

3.times do |n|
  project.areas.create(
      name: "Test Area #{n + 1}",
      description: "Foo",
      floor_plan: File.open(File.join(Rails.root, 'sample_data','sample_floor_plan.pdf' ))
  )
end

#Pins to area
area = project.areas.first
3.times do |n|
  area.pins.create(
      description: "Pin Seed Description #{n}",
      x: rand(),
      y: rand()
  )
end
