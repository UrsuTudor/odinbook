class CreateJoinTableUsersFollowersFollowees < ActiveRecord::Migration[7.2]
  def change
    create_table :users_followers_followees, id: false do |t|
      t.references :follower, foreign_key: { to_table: :users }
      t.references :followee, foreign_key: { to_table: :users }
    end
  end
end
