class Test < ApplicationRecord
  belongs_to :category
  has_many :questions, dependent: :destroy_all
  has_many :results
  has_many :passing_users, through: :results, source: :users

  belongs_to :author, class_name: 'User', foreign_key: :user_id

  validates :level, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, inclusion: 0..3, allow_nil: true

  scope :by_complexity, -> (complexity) do
    levels = case complexity
             when :easy
               0..1
             when :medium
               2..4
             when :hard
               5.. Float::INFINITY

    end
    where(level: levels)
  end

  scope :by_category_name, -> (name) do
    joins(:category)
    .where(categories: { title: name })
  end

  def self.titles_by_category_name(name)
    by_category_name(name).order('tests.title DESC').pluck('tests.title')
  end

  def to_s
    "#{category.title} #{title} #{level} #{author.name}"
  end
end
