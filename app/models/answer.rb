class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_question_answers_count, on: :create

  default_scope -> { order(:id) }
  scope :correct, -> { where(correct: true) }

  private

    def validate_question_answers_count
      errors.add(:question, 'Too much answers') if question.answers.count >= 4
    end
end
