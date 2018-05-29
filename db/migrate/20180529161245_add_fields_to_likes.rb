class AddFieldsToLikes < ActiveRecord::Migration[5.1]
  def change
    add_timestamps :likes, null: true
  end
end
