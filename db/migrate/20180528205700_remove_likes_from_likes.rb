class RemoveLikesFromLikes < ActiveRecord::Migration[5.1]
  def change
    remove_column :likes, :likes, :boolean
  end
end
