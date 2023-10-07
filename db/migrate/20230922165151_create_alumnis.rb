class Createusers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_first_name
      t.string :user_last_name
      t.string :user_email
      t.string :user_ph_num
      t.integer :user_class_year
      t.string :user_job_field
      t.string :user_location
      t.string :user_status
      t.string :user_major

      t.timestamps
    end
  end
end
