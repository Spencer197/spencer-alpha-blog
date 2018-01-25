class SessionsController < ApplicationController
  
def new
  
end

def create
  user = User.find_by(email: params[:session][:email].downcase)#Finds user by email for comparison.
    if user && user.authenticate(params[:session][:password])#If user email exists & password authenticates...
      session[:user_id] = user.id#The session is set to the user's id, which is stored in the user's browser via cookies.
      flash[:success] = "You have logged in successfully."
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with the login information"#'flash.now' makes the flash message disappear after user leaves the new form. 
      render 'new'
    end    
end

def destroy
  session[:user_id] = nil#Sets session user id to nil.
    flash[:success] = "You have logged out successfully."
    redirect_to root_path
end

end