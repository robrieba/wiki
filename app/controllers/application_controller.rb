class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    wiki_entries_path
  end

  def require_sign_in
    unless current_user
      flash[:error] = "You must be logged in to do that."
      redirect_to '/users/sign_in'
    end
  end

end
