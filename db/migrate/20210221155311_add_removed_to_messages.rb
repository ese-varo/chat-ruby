class AddRemovedToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :removed, :boolean, default: false
  end
end
