class RemoveAddressAndProvinceFromOrders < ActiveRecord::Migration[7.2]
  def change
    def change
      remove_column :orders, :address
      remove_column :orders, :province
    end
  end
end
