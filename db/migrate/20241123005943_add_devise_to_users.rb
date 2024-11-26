class AddDeviseToUsers < ActiveRecord::Migration[6.1]
  def up
    # Verifica si las columnas ya existen antes de intentar agregarlas
    unless column_exists?(:users, :email)
      add_column :users, :email, :string, default: "", null: false
    end

    unless column_exists?(:users, :encrypted_password)
      add_column :users, :encrypted_password, :string, default: "", null: false
    end

    unless column_exists?(:users, :reset_password_token)
      add_column :users, :reset_password_token, :string
    end

    unless column_exists?(:users, :reset_password_sent_at)
      add_column :users, :reset_password_sent_at, :datetime
    end

    unless column_exists?(:users, :remember_created_at)
      add_column :users, :remember_created_at, :datetime
    end

    # Agrega índices solo si no existen
    add_index :users, :email, unique: true unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
  end

  def down
    # Elimina columnas solo si existen
    remove_column :users, :email if column_exists?(:users, :email)
    remove_column :users, :encrypted_password if column_exists?(:users, :encrypted_password)
    remove_column :users, :reset_password_token if column_exists?(:users, :reset_password_token)
    remove_column :users, :reset_password_sent_at if column_exists?(:users, :reset_password_sent_at)
    remove_column :users, :remember_created_at if column_exists?(:users, :remember_created_at)
  end
end
