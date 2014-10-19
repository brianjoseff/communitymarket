class AddTimestampToSuperSellerJobs < ActiveRecord::Migration
  def change
    add_column :super_seller_jobs, :created_at, :datetime
    add_column :super_seller_jobs, :updated_at, :datetime
  end
end
