class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  MIN_SUCCESS_PERCENT = 85

  before_validation :before_validation_set_first_question, on: :create

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end
    self.current_question = next_question
    save!
  end

  def complited?
    current_question.nil?
  end

  def percent_result
    100.0 * correct_questions / test.questions.count
    # "#{self.correct_questions} #{test.questions.count}"
  end

  def set_result_to_passed
    passed unless passed.nil?

     in_time =
       if test.timer
         (created_at + test.timer.minutes) < Time.now
       else
         true
       end

    self.passed = in_time && (percent_result >= MIN_SUCCESS_PERCENT)
    self.current_question_id = nil
    save!
  end

  def done_questions_count
    if current_question
      test.questions.where('id < ?', current_question_id).count
    else
      test.questions_count
    end
  end

  private

    def before_validation_set_first_question
      self.current_question = test.questions.first if test.present?
    end

    def correct_answer?(answer_ids)
      answer_ids ||= []
      correct_answers.ids.sort == answer_ids.map(&:to_i).sort
    end

    def correct_answers
      current_question.answers.correct
    end

    def next_question
      test.questions.order(:id).where('id > ?', current_question.id).first
    end
end
