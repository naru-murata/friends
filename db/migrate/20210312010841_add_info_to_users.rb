class AddInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :content, :string
    add_column :users, :icon, :string
  end
end
