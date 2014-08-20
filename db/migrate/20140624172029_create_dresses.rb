class CreateDresses < ActiveRecord::Migration
  def change
    create_table :dresses do |t|
      t.string :size
      t.integer :rental
      t.string :title
      t.integer :retail
      t.text :comments_on_fit

      t.timestamps
    end
  end
end
