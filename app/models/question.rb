class Question < ApplicationRecord
  belongs_to :test
  has_many :answers

  validates :body, presence: true
  validates :answers_count, inclusion: { in: 0..9 }

  def answers_count
    answers.count
  end
  # можно наверно через validate и вызов метода, но это длинно
end
