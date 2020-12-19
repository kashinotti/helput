class AddCulumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_image, :string
    add_column :users, :introduce, :text
    add_column :users, :is_deleted, :boolean, default: false, null: false
  end
end
