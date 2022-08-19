class AddAuthenticationTokenToApplications < ActiveRecord::Migration[5.0]
  def change
    add_column :applications, :authentication_token, :string, limit: 30
    add_index :applications, :authentication_token, unique: true
  end
end
