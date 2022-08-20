class CreateMessageUnique < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :chat, foreign_key: true
      t.string :message
      t.timestamps
    end
  end
end
