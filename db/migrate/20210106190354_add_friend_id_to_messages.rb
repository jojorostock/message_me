class AddFriendIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :friend_id, :integer, :default => 0
  end
end
