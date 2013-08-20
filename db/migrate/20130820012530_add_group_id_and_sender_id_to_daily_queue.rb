class AddGroupIdAndSenderIdToDailyQueue < ActiveRecord::Migration
  def change
    add_column :daily_queues, :group_id, :integer
    add_column :daily_queues, :sender_id, :integer
  end
end
