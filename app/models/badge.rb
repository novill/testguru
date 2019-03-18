class Badge < ApplicationRecord
  belongs_to :badge_type
  belongs_to :object, polymorphic: true, optional: true
end
