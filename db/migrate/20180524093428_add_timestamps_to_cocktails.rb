class AddTimestampsToCocktails < ActiveRecord::Migration[5.1]
  def change
    add_timestamps :cocktails, null: true
  end
end
