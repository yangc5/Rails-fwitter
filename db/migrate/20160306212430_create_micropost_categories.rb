class CreateMicropostCategories < ActiveRecord::Migration
  def change
    create_table :micropost_categories do |t|
      t.integer :micropost_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
