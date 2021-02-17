class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.string :status
      t.integer :last_message_id

      t.timestamps
    end
  end
end
