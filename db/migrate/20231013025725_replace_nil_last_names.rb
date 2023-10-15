class ReplaceNilLastNames < ActiveRecord::Migration[7.0]
  def up
    User.where(user_last_name: nil).update_all(user_last_name: 'Lastname')
  end

  def down
    User.where(user_last_name: 'Lastname').update_all(user_last_name: nil)
  end
end
