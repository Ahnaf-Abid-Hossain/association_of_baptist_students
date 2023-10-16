class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_links

  def check_approval_status
    unless current_user.approval_status == 1 || request.fullpath == '/account_created'
      flash[:alert] = "You are not approved to access this page. Please wait to be approved by an admin."
      redirect_to('/account_created')
    end
  end  

  def account_created
    render 'account_created'
  end

  def set_links
    @links = Link.order(order: :asc)
  end
end
