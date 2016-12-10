class AddContentToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :content, :text
  end
end
