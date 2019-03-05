class Gist < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :url, format: /Ahttps:\/\/gist\.github\.com\/.+\/.+/

  def shorten_body
    body[0..24]
  end
end
