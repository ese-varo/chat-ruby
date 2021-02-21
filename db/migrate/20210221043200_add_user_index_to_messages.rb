class AddUserIndexToMessages < ActiveRecord::Migration[6.1]
  def change
    add_index :messages, :user_id
  end
end
