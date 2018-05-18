class RemoveCreationDateFromCocktails < ActiveRecord::Migration[5.1]
  def change
    change_table :cocktails do |t|
      t.remove :creation_date, :cocktails
    end
  end
end
