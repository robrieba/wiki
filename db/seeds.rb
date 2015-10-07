# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


admin = User.create!(
  email: 'admin@example.com',
  password: 'password',
  role: :admin
)

normal_user_1 = User.create!(
  email: 'user1@example.com',
  password: 'password'
)

normal_user_2 = User.create!(
  email: 'user2@example.com',
  password: 'password'
)

vip_user = User.create!(
  email: 'vip@example.com',
  password: 'password',
  role: :premium
)

# Create standard user wikis
10.times do
  WikiEntry.create!(
    title: Faker::App.name,
    body: Faker::Hacker.say_something_smart,
    private: false,
    user_id: normal_user_1.id
  )
end

10.times do
  WikiEntry.create!(
    title: Faker::University.name,
    body: Faker::Lorem::paragraph(100, true, 10),
    private: false,
    user_id: normal_user_2.id
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
