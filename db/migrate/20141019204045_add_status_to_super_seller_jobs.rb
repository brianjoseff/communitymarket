class AddStatusToSuperSellerJobs < ActiveRecord::Migration
  def change
    add_column :super_seller_jobs, :status, :string, :default => 'active'
  end
end
