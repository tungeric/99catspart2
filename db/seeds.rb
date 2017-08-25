# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
10.times do
  User.create(user_name: Faker::Name.first_name, password: Faker::Name.last_name)
end


Cat.destroy_all
20.times do
  Cat.create(name: Faker::Name.first_name, birth_date: Faker::Date.between(20.years.ago, Date.today), sex: ['M','F'].sample, color: %w(black white orange brown).sample, description: "hi", user_id: rand(1..8))
end

CatRentalRequest.destroy_all
10.times do
  CatRentalRequest.create(cat_id: rand(1..20), start_date: Faker::Date.backward(23), end_date: Faker::Date.forward(99), user_id: rand(1..9))
end
