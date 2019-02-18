class Question < ApplicationRecord
  belongs_to :test
  has_many :answers

  validates :body, presence: true
  validates :answers_count, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 4}

  def answers_count
    answers.count
  end
  # можно наверно через validate и вызов метода, но это длинно

end
