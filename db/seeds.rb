
# Так обычно не делают но ерхоку не дает мне удалять бд через rake db:drop
if ENV['CLEAN_DATABASE_BEFORE_SEED']
  # require 'database_cleaner'
  # DatabaseCleaner.clean_with :deletion
  TestPassage.delete_all
  Answer.delete_all
  Question.delete_all
  Test.delete_all
  User.delete_all
  Category.delete_all
end

['Ruby', 'CSS', 'SQL', 'Marketing', 'Management'].each do |title|
  Category.find_or_create_by(title: title)
end

puts "Созданы категории: #{Category.pluck(:title)}"

user_names = ['John Smith', 'Richard Branson', 'Ilon Mask', 'Ben Davis']
user_names.each_with_index do |name, index|
  User.find_or_create_by!(
    name: name,
    email: "#{name.tr(' ', '')}@example.com") do |user|
      user.password = index.to_s * 6
      user.password_confirmation = user.password
      user.confirmed_at = Time.current
    end
end

User.last.update_attribute(:type, 'Admin')

puts "Созданы пользователи: #{User.all.pluck(:name)}"

puts "Администраторы: #{Admin.all.pluck(:name, :email)}"

default_author = Admin.first

Category.all.each do |category|
  category.tests.find_or_create_by!(
    title: "Beginner test for #{category.title}",
    level: 0,
    author: default_author,
  )
  category.tests.find_or_create_by!(
    title: "Medium test for #{category.title}",
    level: 1,
    author: default_author
  )
end

Category.first(3).each do |category|
  category.tests.find_or_create_by!(
    title: "Hard test for #{category.title}",
    level: 3,
    author: default_author
  )
end

Category.first.tests.update_all('timer = level +1')

puts "Созданы тесты: #{Test.all.map(&:to_s)}"

Test.all.each do |test|
  next if test.questions.any?

  test.questions = Array.new(4) do |number|
    number += 1
    Question.new(body: "Question body #{number} for #{test}")
  end
end

puts "Создано вопросов: #{Question.all.count}"

Question.all.each do |question|
  next if question.answers.any?

  question.answers = Array.new(4) do |number|
    number += 1
    correct = (question.id + number).even?
    Answer.new(
      body: "Answer #{number} for question #{question.id} #{correct ? 'c' : ''}",
      correct: correct
    )
  end
end

puts "Создано ответов: #{Answer.all.count}"

# User.first.passing_tests = Category.first.tests
# User.second.passing_tests = Category.second.tests.first(2)
# User.third.passing_tests = Test.where(level: 0)
#
# puts "Пользователи распределены по тестам"
# User.all.each { |u|  puts "#{u.name} #{u.passing_test_ids}" }
