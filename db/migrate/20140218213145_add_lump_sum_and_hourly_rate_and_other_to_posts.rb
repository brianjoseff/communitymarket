class AddLumpSumAndHourlyRateAndOtherToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :lump_sum, :integer
    add_column :posts, :hourly_rate, :integer
    add_column :posts, :other, :string
  end
end
