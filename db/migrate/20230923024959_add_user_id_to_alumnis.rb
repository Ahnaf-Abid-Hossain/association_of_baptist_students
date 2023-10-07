class AddUserIdToAlumnis < ActiveRecord::Migration[7.0]
  def change
    add_column :alumnis, :user_id, :integer
  end
end
