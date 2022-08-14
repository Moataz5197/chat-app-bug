class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.references :application, foreign_key: true
      t.integer :chat_number
      t.integer :messages_count
      t.timestamps
    end
  end
end
