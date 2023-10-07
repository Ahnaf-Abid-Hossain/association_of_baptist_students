class MergeuserIntoUsers < ActiveRecord::Migration[7.0]
  def change
    # adding new columns
    add_column :users, :user_first_name, :string
    add_column :users, :user_last_name, :string
    add_column :users, :user_contact_email, :string # take out this one?
    add_column :users, :user_ph_num, :string
    add_column :users, :user_class_year, :integer
    add_column :users, :user_job_field, :string
    add_column :users, :user_location, :string
    add_column :users, :user_status, :string # need this one?
    add_column :users, :user_major, :string

    # migrate data from user to User
    user.all.each do |user|
      user = User.find_by(email:user.user_email)
      user.update(user_first_name: user.user_first_name, user_last_name: user.user_last_name, user_contact_email: user.user_email, user_ph_num: user.user_ph_num, user_class_year: user.user_class_year, user_job_field: user.user_job_field, user_location: user.user_location, user_status: user.user_status, user_major: user.user_major)
    end

    rename_foreign_keys

    # drop_table :users
  end

  def rename_foreign_keys
    rename_column :meeting_notes, :users, :users, column: "id"
    rename_column :prayer_requests, :users, :users, column: "id"
  end
end
