class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.boolean :borrow
      t.integer :tier
      t.text :description
      t.integer :user_id
      t.integer :post_category_id
      t.boolean :premium

      t.timestamps
    end
  end
end
