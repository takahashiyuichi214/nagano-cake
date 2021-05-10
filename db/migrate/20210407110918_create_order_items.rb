class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      
      t.integer :item_id
      t.integer :order_id
      t.integer :price
      t.integer :amount
      t.integer :making_status, default:false

      t.timestamps
    end
    add_index :order_items, :order_id
  end
end
