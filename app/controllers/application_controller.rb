class ApplicationController < ActionController::Base
  # ✅ Devise: after login for regular users
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path   # Admin dashboard
    else
      books_path        # Regular user books page
    end
  end

  # ✅ Devise: after logout
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin_user
      new_admin_user_session_path
    else
      root_path
    end
  end

  # ✅ Prevent signed-in users from visiting sign-in/up pages again
  before_action :redirect_signed_in_user, if: :user_signed_in?

  private

  def redirect_signed_in_user
    # Skip this check for ActiveAdmin
    return if self.class < ActiveAdmin::BaseController

    if request.path.in?(['/users/sign_in', '/users/sign_up'])
      redirect_to books_path
    end
  end
end
