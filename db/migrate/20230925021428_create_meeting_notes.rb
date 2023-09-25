class CreateMeetingNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :meeting_notes do |t|
      t.string :title
      t.text :content
      t.date :date
      t.references :alumni, foreign_key: true

      t.timestamps
    end
  end
end
