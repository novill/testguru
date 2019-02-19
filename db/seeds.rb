# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Ruby', 'CSS', 'SQL', 'Marketing', 'Management'].each do |title|
  Category.find_or_create_by(title: title)
end

puts "Созданы категории: #{Category.pluck(:title)}"

['Jonh Smith', 'Richard Branson', 'Ilon Mask', 'Ben Davis'].each do |name|
  User.find_or_create_by(
    name: name,
    email: "#{name.tr(' ', '')}@example.com"
  )
end

puts "Созданы пользователи: #{User.all.pluck(:name)}"

default_author = User.last

Category.all.each do |category|
  category.tests.find_or_create_by(
    title: "Beginner test for #{category.title}",
    level: 0,
    author: default_author
  )
  category.tests.find_or_create_by(
    title: "Medium test for #{category.title}",
    level: 2,
    author: default_author
  )
end

Category.first(3).each do |category|
  category.tests.find_or_create_by(
    title: "Hard test for #{category.title}",
    level: 5,
    author: default_author
  )
end

puts "Созданы тесты: #{Test.all.map(&:to_s)}"

Test.all.each do |test|
  next if test.questions.any?

  test.questions = Array.new(2) do |number|
    number += 1
    Question.new(body: "Question body #{number} for #{test}")
  end
end

puts "Создано вопросов: #{Question.all.count}"

Question.all.each do |question|
  next if question.answers.any?

  question.answers = Array.new(2) do |number|
    number += 1
    Answer.new(
      body: "Answer #{number} for question #{question.id}",
      correct: (question.id + number).even?
    )
  end
end

puts "Создано ответов: #{Answer.all.count}"

User.first.passing_tests = Category.first.tests
User.second.passing_tests = Category.second.tests.first(2)
User.third.passing_tests = Test.where(level: 0)

puts "Пользователи распределены по тестам"
User.all.each { |u|  puts "#{u.name} #{u.passing_test_ids}" }
