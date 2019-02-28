class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :authored_tests, class_name: 'Test', foreign_key: :user_id
  has_many :test_passages
  has_many :tests, through: :test_passages

  # validates :name, presence: true
  validates :email, presence: true
  validates_format_of :email, with: /.+@.+\..+/i
  validates :email, uniqueness: true

  # scope :test_by_level, ->(level) { passing_tests.where(level: level) }

  def to_s
    name
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
