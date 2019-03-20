class Badge < ApplicationRecord
  ALLOWED_OBJECT_TYPES = ['Category', 'Test', 'Level']
  belongs_to :badge_type
  belongs_to :object, polymorphic: true, optional: true

  scope :active, -> {where(active: true)}

  def to_s
    "#{badge_type.name} for #{object_type} #{object_id}"
  end
end
