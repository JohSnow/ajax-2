class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps

      add_column :posts, :category_id, :integer
      add_index :posts, :category_id
    end
  end
end
