class Admin < User
  validates :name, presence: true
end
