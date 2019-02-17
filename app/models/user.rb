class User < ApplicationRecord
  has_many :results
  has_many :passing_tests, through: :results, source: :test

  has_many :tests

  # Создайте инстанс-метод в модели User, который принимает в качестве аргумента
  # значение уровня сложности и возвращает список всех Тестов,
  # которые проходит или когда-либо проходил Пользователь на этом уровне сложности
  def test_by_level(level)
    passing_tests.where(level: level)
  end
end
