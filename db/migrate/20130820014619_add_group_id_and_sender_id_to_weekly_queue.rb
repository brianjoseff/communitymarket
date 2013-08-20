class AddGroupIdAndSenderIdToWeeklyQueue < ActiveRecord::Migration
  def change
    add_column :weekly_queues, :group_id, :integer
    add_column :weekly_queues, :sender_id, :integer
  end
end
