ActiveAdmin.register Category do

  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  # Formulario para crear o editar categorías
  form do |f|
    f.inputs "Category Details" do
      f.input :name
    end
    f.actions
  end
end
