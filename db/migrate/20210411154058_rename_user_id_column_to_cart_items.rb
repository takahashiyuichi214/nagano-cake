class RenameUserIdColumnToCartItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :cart_items, :user_id, :customer_id
  end
end
