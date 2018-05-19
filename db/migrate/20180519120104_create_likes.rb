class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.boolean :like
      t.integer :review_id
      t.integer :user_id
    end
  end
end
