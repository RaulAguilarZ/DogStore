class CreateProvinceTaxes < ActiveRecord::Migration[7.2]
  def change
    create_table :province_taxes do |t|
      t.string :name
      t.decimal :tax_rate

      t.timestamps
    end
  end
end
