class ApprovalsController < ApplicationController
  before_action :require_admin
  def index
    # @non_admin_alumni = Alumni.where.not(alum_status: 'admin')
    @non_admins = User.where(approval_status: 0)
  end

  def require_admin
    unless current_user&.is_admin
      flash[:alert] = 'You do not have permission to access this page.'
      redirect_to(root_path) # or any other path you prefer
    end
  end

  def show_users
    @users_all = User.all
  end

  def show_rejected_users
    @rejected_users = User.where(approval_status: -1)
  end



end
