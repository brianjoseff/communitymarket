class AddPriceToTier < ActiveRecord::Migration
  def change
    add_column :tiers, :price, :integer
  end
end
