class AddIsAnonymousToPrayerRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :prayer_requests, :is_anonymous, :boolean
  end
end
