class AddPrivacyFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_contact_email_private, :boolean, default: false
    add_column :users, :is_ph_num_private, :boolean, default: false
    add_column :users, :is_class_year_private, :boolean, default: false
    add_column :users, :is_job_field_private, :boolean, default: false
    add_column :users, :is_location_private, :boolean, default: false
    add_column :users, :is_status_private, :boolean, default: false
    add_column :users, :is_major_private, :boolean, default: false
  end
end
