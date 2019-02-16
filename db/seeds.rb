# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Ruby', 'CSS', 'SQL', 'Marketing', 'Management'].each { |title| Category.find_or_create_by(title: title) }

Category.all.each do |category|
  category.tests.find_or_create_by(title: "Beginner test for #{category.title}", level: 0)
  category.tests.find_or_create_by(title: "Medium test for #{category.title}", level: 1)
end

Category.first(3).each { |category| category.tests.find_or_create_by(title: "Hard test for #{category.title}", level: 2) }

['Jonh Smith', 'Richard Branson', 'Ilon Mask', 'Ben Davis'].each { |name| User.find_or_create_by(name: name) }
['Jonh Smith', 'Richard Branson', 'Ilon Mask', 'Ben Davis'].each { |name| User.find_or_create_by(name: name) }

User.first.tests = Category.first.tests
User.second.tests = Category.second.tests.first(2)
User.third.tests = Test.where(level: 0)
