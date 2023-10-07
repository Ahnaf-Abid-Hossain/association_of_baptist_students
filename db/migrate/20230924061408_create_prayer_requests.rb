class CreatePrayerRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :prayer_requests do |t|
      t.string :request
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
