class AddNameToConversations < ActiveRecord::Migration[6.1]
  def change
    add_column :conversations, :name, :string
  end
end
