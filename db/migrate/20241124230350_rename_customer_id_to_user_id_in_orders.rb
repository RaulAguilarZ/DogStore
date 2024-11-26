class RenameCustomerIdToUserIdInOrders < ActiveRecord::Migration[7.2]
  def change
    rename_column :orders, :customer_id, :user_id
  end
end
