class RenameIdCategoryToCategoryIdInProducts < ActiveRecord::Migration[7.2]
  def change
    rename_column :products, :id_category, :category_id
  end
end
