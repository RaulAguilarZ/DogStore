ActiveAdmin.register Product do
  # Campos permitidos para crear/actualizar
  permit_params :name, :description, :price, :available_quantity, :category_id, :image

  # Filtros personalizados
  filter :name
  filter :description
  filter :price
  filter :category
  filter :created_at
  filter :updated_at

  # Configuración del formulario (opcional)
  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :available_quantity
      f.input :category?
      f.input :image, as: :file
    end
    f.actions
  end
end
