class AddCocktails < ActiveRecord::Migration[5.1]
  def change
    create_table :cocktail do |t|
        t.string 'name'
        t.text 'description'
        t.references 'user'
    end
  end
end
