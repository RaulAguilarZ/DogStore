class CreateOutputs < ActiveRecord::Migration[7.2]
  def change
    create_table :outputs do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.date :output_date

      t.timestamps
    end
  end
end
