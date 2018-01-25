class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?#Lets Rails know that these methods are helper methods & therefore make them available to our views.
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]#If user has not (||=) already been found in the database that matches the user id in the browser's session hash, find the matching user. 
  end
  
  def logged_in?
    !!current_user#A boolean expression (!!) to determine if a user is already logged in or not.
  end
  
  def require_user
    if !logged_in?#If not (!) logged in...
      flash[:danger] = "You need to be logged in to perform that action"
      redirect_to root_path
    end
  end
end
