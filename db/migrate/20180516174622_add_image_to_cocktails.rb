class AddImageToCocktails < ActiveRecord::Migration[5.1]
  def change
    add_column :cocktails, :image, :string
  end
end
