class ApplicationController < ActionController::Base
  include SessionsHelper
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def require_user_administrator
    unless current_user.administrator
      redirect_to '/'
    end
  end
  
  
end
