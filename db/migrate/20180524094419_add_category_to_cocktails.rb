class AddCategoryToCocktails < ActiveRecord::Migration[5.1]
  def change
    add_column :cocktails, :category, :string
  end
end
