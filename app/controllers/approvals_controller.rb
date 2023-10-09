class ApprovalsController < ApplicationController
  def index
    # @non_admin_alumni = Alumni.where.not(alum_status: 'admin')
    @non_admins = User.where.not(user_status: 'admin')
  end
end
