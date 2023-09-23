class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :redirect_to_new_alumni!

  # If the user has not made a profile yet, very angrily send them there
  protected
  def redirect_to_new_alumni!
    if user_signed_in? and current_user.alumni == nil
      redirect_to new_alumni_path
    end
  end

  # # Function to keep us from calling new alumni path repeatedly
  # private
  # def is_new_alumni_path
  #   request.path.end_with? "/alumnis/new"
  # end

  # protected
  # def authenticate_user!
  #   # If user has not made a profile yet, very angrily send them there
  #   # (also pls don't recursively redirect)
  #   if not is_new_alumni_path and user_signed_in? and current_user.alumni == nil
  #     print request
  #     redirect_to new_alumni_path
  #   else
  #     super
  #   end
  # end
end
