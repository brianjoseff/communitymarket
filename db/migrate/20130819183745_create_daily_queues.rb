class CreateDailyQueues < ActiveRecord::Migration
  def change
    create_table :daily_queues do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
