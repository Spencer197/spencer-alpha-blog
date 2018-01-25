class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit, :update, :show]#These methods have redundancies extracted to the private set_user method.
  before_action :require_same_user, only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)  
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id#Sets session to user_id
      flash[:success] = "Welcome to the alpha blog #{@user.username}"
      redirect_to user_path(@user)#Directs newly signed up user to the user's profile show page upon sign up.
    else
      render 'new'
    end
  end
  
  def edit
    #@user = User.find(params[:id]) - Extracted to private method below
  end
  
  def update
    #@user = User.find(params[:id]) - Extracted to private method below
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  
  def show
    #@user = User.find(params[:id]) - Extracted to private method below.
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)#Creates the @user_articles instance variable, then uses standard pagination syntax to paginate the user's articles.
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if current_user != @user
      flash[:danger] = "You can only edit your own account."
      redirect_to root_path
    end
  end

end