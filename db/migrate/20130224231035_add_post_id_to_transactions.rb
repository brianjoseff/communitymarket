class AddPostIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :post_id, :integera
  end
end
