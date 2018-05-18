class CreateFavoriteCocktails < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_cocktails do |t|
      t.integer :cocktail_id
      t.integer :user_id

      t.timestamps
    end
  end
end
