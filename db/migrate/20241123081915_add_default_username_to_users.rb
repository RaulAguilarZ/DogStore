class AddDefaultUsernameToUsers < ActiveRecord::Migration[7.2]
  def change
     change_column_default :users, :username, "guest"
  end
end
