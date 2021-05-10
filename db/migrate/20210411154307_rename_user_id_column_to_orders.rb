class RenameUserIdColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :user_id, :customer_id
  end
end
