class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rate
      t.text :comments
      t.references :cocktail
      t.references :user
    end
  end
end
