class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    books_path  # Login ke baad user automatically browse books page pe jaye
  end
end
