class AddUserIdToLink < ActiveRecord::Migration[7.0]
  def change
    add_reference :links, :user, foreign_key: true

    # Wire all previous links to belong to seeded admin
    seeded_admin = User.find_by(email: 'johnsmithuser3210@gmail.com')
    Link.all.each do |link|
      link.user = seeded_admin
      link.save!
    end
  end
end
