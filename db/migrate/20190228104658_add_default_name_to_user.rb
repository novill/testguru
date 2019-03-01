class AddDefaultNameToUser < ActiveRecord::Migration[5.2]
  def change
    # Отключу пока, потом подумаю как доработать devise для обратоки
    change_column_default(:users, :name, from: nil, to: '')
  end
end
