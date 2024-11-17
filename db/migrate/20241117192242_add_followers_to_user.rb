class AddFollowersToUser < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :follower, foreign_key: { to_table: :users }
    add_reference :users, :followee, foreign_key: { to_table: :users }
  end
end
