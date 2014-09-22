class CreateSuperSellerJobs < ActiveRecord::Migration
  def up
    create_table :super_seller_jobs do |t|
      t.integer :owner_id
      t.integer :super_seller_id
      t.string :estimated_value
      t.integer :sell_options
      t.string :pickup_location
      t.text :notes
    end

    add_index :super_seller_jobs, :owner_id
    add_index :super_seller_jobs, :super_seller_id
  end

  def down
    drop_table :super_seller_jobs
  end



end
