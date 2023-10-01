class CreateAlumnis < ActiveRecord::Migration[7.0]
  def change
    create_table :alumnis do |t|
      t.string :alum_first_name
      t.string :alum_last_name
      t.string :alum_email
      t.string :alum_ph_num
      t.integer :alum_class_year
      t.string :alum_job_field
      t.string :alum_location
      t.string :alum_status
      t.string :alum_major

      t.timestamps
    end
  end
end
