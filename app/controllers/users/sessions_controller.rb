class Users::SessionsController < Devise::SessionsController
  # Helper for linking to post-"sign out"
  # (in this case, to new session path)
  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  # Helper for linking to post-"sign in"
  # (in this case, home or the URL param)
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end
end
