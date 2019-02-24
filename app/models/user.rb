class User < ApplicationRecord

  has_many :tests

  validates :name, :email, presence: true

  # scope :test_by_level, ->(level) { passing_tests.where(level: level) }

  def to_s
    name
  end
end
