class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true

  # При добавлении нового ответа их должно быть меньше 4
  # validates :question_answers_count, numericality: { less_than: 4 }, on: :create

  validate :validate_question_answers_count, on: :create

  scope :correct, -> { where(correct: true) }

  private

    def validate_question_answers_count
      errors.add(:question, 'Too much answers') if question.answers.count >= 4
    end

  # def question_answers_count
  #   question.answers.count
  # end
end
