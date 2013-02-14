class AddImageableTypeToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :imageable_type, :string
  end
end
