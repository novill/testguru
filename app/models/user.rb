class User < ApplicationRecord
  has_many :results
  has_many :passing_tests, through: :results, source: :test

  has_many :tests

  validates :name, :email, presence: true

  scope :test_by_level, ->(level) { passing_tests.where(level: level) }
end
