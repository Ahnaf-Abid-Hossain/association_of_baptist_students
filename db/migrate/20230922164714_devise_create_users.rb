# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :full_name
      t.string :uid
      t.string :avatar_url
      
      # Custom, for the admin privilege
      t.boolean :is_admin

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
