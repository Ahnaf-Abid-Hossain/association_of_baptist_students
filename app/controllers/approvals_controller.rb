class ApprovalsController < ApplicationController
  def index
    @non_admin_alumni = Alumni.where.not(alum_status: 'admin')
  end
end
