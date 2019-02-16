class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :results
  has_many :users, through: :results

  # Создайте метод класса в модели Test,
  # который возвращает отсортированный по убыванию массив названий всех Тестов
  # у которых Категория называется определённым образом
  # (название категории передается в метод в качестве аргумента).

  # Я не понял по шаблону или прямо по имени

  def self.titles_by_category(template)
    Test.joins(:category).where("categories.title like ?", "%#{template}%").order('tests.title DESC').pluck('tests.title')
  end

  def self.titles_by_category_name(name)
    Test.joins(:category).where({categories: {title: name}}).order('tests.title DESC').pluck('tests.title')
  end
end
