class AddImageToCocktails < ActiveRecord::Migration[5.1]
  def change
    add_column :cocktails, :image, :string
    add_index :cocktails, :image
  end
end
