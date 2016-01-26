class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :p_name
      t.float :price
      t.integer :p_code

      t.timestamps null: false
    end
  end
end
