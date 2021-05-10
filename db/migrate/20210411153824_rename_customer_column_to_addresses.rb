class RenameCustomerColumnToAddresses < ActiveRecord::Migration[5.2]
  def change
  rename_column :addresses, :customer, :customer_id

  end
end
