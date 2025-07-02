class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.date :target_date, null: false
      t.boolean :done, default: false, null: false
      t.boolean :is_public, default: true, null: false
      t.references :user, foreign_key: true
      t.timestamps

    end
    add_index :tasks, [:user_id, :target_date], unique: true

  end
end
