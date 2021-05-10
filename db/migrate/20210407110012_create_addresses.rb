class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      
      t.integer :customer_id
      t.string :name
      t.string :postal_code
      t.text :address      
      

      t.timestamps
    end
    add_index :addresses, :customer_id
  end
end
