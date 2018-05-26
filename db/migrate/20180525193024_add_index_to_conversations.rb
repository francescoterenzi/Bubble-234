class AddIndexToConversations < ActiveRecord::Migration[5.1]
  def change
    add_index :conversations, [:recipient_id, :sender_id], unique: true
  end
end
