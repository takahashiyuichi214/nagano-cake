class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      
      t.integer :customer_id
      t.string :postal_code      
      t.string :address
      t.string :name
      t.integer :shipping_cost
      t.integer :total_payment
      t.integer :payment_method, default: false

      
      t.integer :status, default: false

      t.timestamps
    end
	  add_index :orders, :customer_id
  end
end
