class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :delete_all

  validates :body, presence: true
end
