class RemoveLikeFromLikes < ActiveRecord::Migration[5.1]
  def change
    remove_column :likes, :like, :boolean
  end
end
