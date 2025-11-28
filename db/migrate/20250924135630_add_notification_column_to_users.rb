class AddNotificationColumnToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :notification_time, :time
    add_column :users, :notification_enabled, :boolean
  end
end
