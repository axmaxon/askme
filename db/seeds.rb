# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# Создадим 30 юзеров с валидными данными, у каждого по 1-му вопросу
30.times do |n|
  name = Faker::Name.first_name
  username = "#{Faker::Internet.username(specifier: name)}_#{n}"
  user = User.new(
    name: name,
    username: username,
    email: Faker::Internet.free_email(name: username),
    password: '12345'
  )
  user.save!
  question = Question.new(
    user: user,
    text: "Do you #{Faker::Verb.base}?"
  )
  question.save!
  end
