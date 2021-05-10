class RenameUserIdColumnToAddresses < ActiveRecord::Migration[5.2]
  def change
    rename_column :addresses, :user_id, :customer
  end
end
