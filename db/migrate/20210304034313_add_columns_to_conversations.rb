class AddColumnsToConversations < ActiveRecord::Migration[6.1]
  def change
    add_column :conversations, :description, :text
    add_column :conversations, :emoji, :string
  end
end
