class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description
      t.string :country, null: false
      t.text :tags
      t.float :price, null: false
      t.timestamps
    end
  end
end
