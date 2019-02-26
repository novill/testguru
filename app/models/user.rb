class User < ApplicationRecord
  has_many :authored_tests, class_name: 'Test', foreign_key: :user_id
  has_many :test_passages
  has_many :tests, through: :test_passages

  validates :name, :email, presence: true

  # scope :test_by_level, ->(level) { passing_tests.where(level: level) }

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def to_s
    name
  end
end
