class AddColumnsToVote < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :topic_id, :integer
    add_column :votes, :user_id, :integer
    add_column :votes, :count, :integer
  end
end
