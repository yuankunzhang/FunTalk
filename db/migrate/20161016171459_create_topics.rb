class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :subject
      t.text :description
      t.boolean :completed, :default => false
      t.date :completed_at
      t.integer :vote, :default => 0
      t.date :created_at

      t.timestamps
    end
  end
end
