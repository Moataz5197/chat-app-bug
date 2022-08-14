class AddAuthenticationTokenToApplication < ActiveRecord::Migration[5.0]
  def change
    add_column :applications, :application_token, :string, limit: 30
    add_index :applications, :application_token, unique: true
  end
end
