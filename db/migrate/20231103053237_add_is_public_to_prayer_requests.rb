class AddIsPublicToPrayerRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :prayer_requests, :is_public, :boolean
  end
end
