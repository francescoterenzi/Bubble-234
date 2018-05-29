class ChangeColumnsToLikes < ActiveRecord::Migration[5.1]
  def change
    change_column_null :likes, :created_at, false
    change_column_null :likes, :updated_at, false
  end
end
