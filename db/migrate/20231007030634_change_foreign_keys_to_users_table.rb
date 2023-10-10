class ChangeForeignKeysToUsersTable < ActiveRecord::Migration[7.0]
  def change
    # Remove the existing foreign keys
    remove_foreign_key :meeting_notes, column: :alumni_id
    remove_foreign_key :prayer_requests, column: :alumni_id

    # Rename columns
    rename_column :meeting_notes, :alumni_id, :user_id
    rename_column :prayer_requests, :alumni_id, :user_id

    # Add new foreign keys to the 'users' table
    add_foreign_key :meeting_notes, :users, on_delete: :cascade
    add_foreign_key :prayer_requests, :users, on_delete: :cascade
  end
end

