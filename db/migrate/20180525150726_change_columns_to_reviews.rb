class ChangeColumnsToReviews < ActiveRecord::Migration[5.1]
  def change
    change_column_null :reviews, :created_at, false
    change_column_null :reviews, :updated_at, false
  end
end
