class ApprovalsController < ApplicationController
  before_action :require_admin
  helper ProfanityHelper
  def index
    # Here we are looking at all unapproved users (approval_status = 0)
    # but only users with completed profiles (user_first_name != "")
    @non_admins = User.where(approval_status: 0).and(User.where.not(user_first_name: ""))
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
