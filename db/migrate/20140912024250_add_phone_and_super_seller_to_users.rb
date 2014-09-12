class AddPhoneAndSuperSellerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :super_seller, :boolean, :default => false
    add_column :users, :phone, :string
  end
end
