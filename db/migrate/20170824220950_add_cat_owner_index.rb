class AddCatOwnerIndex < ActiveRecord::Migration[5.1]
  def change
    remove_column :cats, :user_id
    add_column :cats, :user_id, :integer, null: false
  end
end
