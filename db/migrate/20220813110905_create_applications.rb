class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.integer :application_id
      t.string :application_name
      t.integer :chat_count
      t.timestamps
    end
  end
end
