class AddVideoToCocktail < ActiveRecord::Migration[5.1]
  def change
    add_reference :cocktails, :video, foreign_key: true
  end
end
