class Category < ApplicationRecord
  has_many :tests

  validates :title, presence: true

  default_scope { order(:title) }

  def to_s
    "#{id} #{title}"
  end
end
