class MergeAlumniIntoUsers < ActiveRecord::Migration[7.0]
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

    # migrate data from Alumni to User
    Alumni.all.each do |alumni|
      # user = User.find_by(email:alumni.alum_email)
      user = alumni.user
      user.update(user_first_name: alumni.alum_first_name, user_last_name: alumni.alum_last_name, user_contact_email: alumni.alum_email, user_ph_num: alumni.alum_ph_num, user_class_year: alumni.alum_class_year, user_job_field: alumni.alum_job_field, user_location: alumni.alum_location, user_status: alumni.alum_status, user_major: alumni.alum_major)
    end

    # rename_foreign_keys

    # drop_table :alumnis
  end

  # def rename_foreign_keys
    # rename_column :meeting_notes, :alumnis, :users, column: "id"
    # rename_column :prayer_requests, :alumnis, :users, column: "id"
  # end
end
