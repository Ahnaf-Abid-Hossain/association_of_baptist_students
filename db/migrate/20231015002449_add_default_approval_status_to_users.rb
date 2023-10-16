class AddDefaultApprovalStatusToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :approval_status, 0
  end
end
