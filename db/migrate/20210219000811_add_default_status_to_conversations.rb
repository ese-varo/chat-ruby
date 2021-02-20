class AddDefaultStatusToConversations < ActiveRecord::Migration[6.1]
  def change
    change_column :conversations, :status, :string, default: 'public'
  end
end
