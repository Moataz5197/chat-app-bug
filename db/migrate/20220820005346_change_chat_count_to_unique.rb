class ChangeChatCountToUnique < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.references :application, foreign_key: true
      t.integer :chat_number, unique: true
      t.integer :messages_count, unique:
      t.timestamps
    end
  end
end
