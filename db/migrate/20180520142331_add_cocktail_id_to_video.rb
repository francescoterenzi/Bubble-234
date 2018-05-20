class AddCocktailIdToVideo < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :cocktail_id, :integer
  end
end
