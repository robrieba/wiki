# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!(
  name: Faker::Name.name,
  email: 'admin@example.com',
  password: 'password',
  role: :admin
)

normal_user_1 = User.create!(
  name: Faker::Name.name,
  email: 'standard@example.com',
  password: 'password'
)

vip_user = User.create!(
  name: Faker::Name.name,
  email: 'premium@example.com',
  password: 'password',
  role: :premium
)

# Create a large user base for stress testing
200.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password'
  )
end

# Create standard user wikis
10.times do
  WikiEntry.create!(
    title: Faker::App.name,
    body: Faker::Hacker.say_something_smart,
    private: false,
    user_id: normal_user_1.id
  )
end

# Create premium user wikis
10.times do
  WikiEntry.create!(
    title: Faker::Book.title,
    body: Faker::Lorem::paragraph(100, true, 10),
    private: false,
    user_id: vip_user.id
  )
end
