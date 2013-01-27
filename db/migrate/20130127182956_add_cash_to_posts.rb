class AddCashToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :cash, :boolean
  end
end
