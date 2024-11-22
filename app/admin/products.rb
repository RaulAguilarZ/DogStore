ActiveAdmin.register Product do
  permit_params :name, :description, :price, :available_quantity, :category_id, :image

  filter :name
  filter :description
  filter :price
  filter :category
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :available_quantity
      f.input :category, as: :select, collection: Category.all.pluck(:name, :id)
      f.input :image, as: :file
    end
    f.actions
  end

  # Vista de índice para mostrar los productos
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :available_quantity
    column :category
    column :image do |product|
      if product.image.attached?
        image_tag product.image.variant(resize_to_fill: [50, 50]).processed
      end
    end
    actions
  end
end
