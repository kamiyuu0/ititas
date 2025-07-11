class AddMoodToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :mood, :string
  end
end
