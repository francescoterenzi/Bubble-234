class CreateCocktails < ActiveRecord::Migration[5.1]
  def change
    create_table :cocktails do |t|
    t.string :name
    t.text :description
    t.timestamps
    end
  add_index :cocktails, :name, unique: true
  end
end
