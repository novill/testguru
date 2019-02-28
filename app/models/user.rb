require 'digest/sha1'

class User < ApplicationRecord
  has_many :authored_tests, class_name: 'Test', foreign_key: :user_id
  has_many :test_passages
  has_many :tests, through: :test_passages

  validates :name, :email, presence: true
  validates_format_of :email, with: /.+@.+\..+/i
  validates :email, uniqueness: true

  has_secure_password

  # scope :test_by_level, ->(level) { passing_tests.where(level: level) }

  def to_s
    name
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  private

    def digest(string)
      Digest::SHA1.hexdigest(string)
    end
end
