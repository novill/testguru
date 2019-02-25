class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create

  def accept!(answer_ids)
    puts __method__
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end
    # Уточнить почему для обращения к атрибутам нужен self

    self.current_question = next_question
    save!
  end

  def complited?
    current_question.nil?
  end

  def percent_result
    100.0 * self.correct_questions / test.questions.count
    # "#{self.correct_questions} #{test.questions.count}"
  end

  private
    def before_validation_set_first_question
      puts __method__

      self.current_question = test.questions.first if test.present?
    end

    def correct_answer?(answer_ids)
      puts __method__
      correct_answers.ids.sort == answer_ids.map(&:to_i).sort
    end

    def correct_answers
      puts __method__
      current_question.answers.correct
    end

    def next_question
      puts __method__
      test.questions.order(:id).where('id > ?', current_question.id).first
    end
end