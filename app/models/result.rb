class Result < ApplicationRecord
  # аттрибут result = 0 пока пользователь не прошел тест,
  # потом туда записывает разультат прохождения,
  # и тест считается пройденным
  belongs_to :user
  belongs_to :test
end
