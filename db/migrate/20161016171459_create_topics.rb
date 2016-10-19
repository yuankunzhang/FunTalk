class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :subject
      t.text :description
      t.boolean :done, :default => false
      t.date :created_at

      t.timestamps
    end
  end
end
