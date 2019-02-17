class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :results
  has_many :passing_users, through: :results, source: :users

  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id'
  # Создайте метод класса в модели Test,
  # который возвращает отсортированный по убыванию массив названий всех Тестов
  # у которых Категория называется определённым образом
  # (название категории передается в метод в качестве аргумента).

  def self.titles_by_category_name(name)
    Test.joins(:category)
        .where(categories: { title: name })
        .order('tests.title DESC')
        .pluck('tests.title')
  end

  def to_s
    "#{category.title} #{title} #{level} #{author.name}"
  end
end
