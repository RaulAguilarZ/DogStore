class AddDeviseToAdminUsers < ActiveRecord::Migration[7.2]
  def self.up
    change_table :admin_users do |t|
      # Solo agrega la columna si no existe
      t.string :email,              null: false, default: "" unless column_exists?(:admin_users, :email)
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:admin_users, :encrypted_password)

      # Agregar las demás columnas solo si no existen
      t.string   :reset_password_token unless column_exists?(:admin_users, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:admin_users, :reset_password_sent_at)
      t.datetime :remember_created_at unless column_exists?(:admin_users, :remember_created_at)
    end

    # Solo agregar índices si no existen
    add_index :admin_users, :email,                unique: true unless index_exists?(:admin_users, :email)
    add_index :admin_users, :reset_password_token, unique: true unless index_exists?(:admin_users, :reset_password_token)
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
