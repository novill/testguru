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

  has_many :user_badges
  has_many :badges, through: :user_badges

  validates :email, presence: true
  validates_format_of :email, with: /.+@.+\..+/i
  validates :email, uniqueness: true

  def admin?
    is_a?(Admin)
  end

  def to_s
    name
  end

  def test_passage(test)
    puts __method__, 'удалить'
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def unfinished_test(test)
    test_passages.where(passed: nil).order(id: :desc).find_by(test_id: test.id)
  end
end
