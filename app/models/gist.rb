class Gist < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :url, format: /\Ahttps:\/\/gist\.github\.com\/.+/

  def shorten_question
    question.body.truncate(25)
  end
end
