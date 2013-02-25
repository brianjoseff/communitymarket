class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :price
      t.integer :tier_id
      t.boolean :premium
      t.integer :notify_premium
      t.integer :user_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
