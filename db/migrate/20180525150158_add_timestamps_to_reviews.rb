class AddTimestampsToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :created_at, :datetime
    add_column :reviews, :updated_at, :datetime
  end
end
