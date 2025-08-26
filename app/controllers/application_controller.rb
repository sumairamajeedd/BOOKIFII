
class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    books_path  # Login SUCCESS ke baad books page
  end
 
  def authenticate_user!
    if user_signed_in?
      redirect_to books_path and return if request.path.in?(['/users/sign_in', '/users/sign_up'])
    else
      super
    end
  end
end