class CreateSuppliers < ActiveRecord::Migration[7.2]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :contact
      t.text :address
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
