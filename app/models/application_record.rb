class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  default_scope -> { order(:id) } # Postgres последние измененные записи в конец ставит
end
