class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]#Requires user to be admin for all actions except index & show.
  
def index
  @categories = Category.paginate(page: params[:page], per_page: 5)
end

def new
  @category = Category.new
end

def create
  @category = Category.new(category_params)#Calls the private method category_params
  if @category.save
    flash[:success] = "Category was created successfully"
    redirect_to categories_path
  else
    render 'new'
  end
end

def edit
  @category = Category.find(params[:id])
end

def update
  @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Category name was updated successfully"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
end

def show
  @category = Category.find(params[:id])#Finds each category.
  @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)#paginates categories 5 per page.
end

private
  
  def category_params
    params.require(:category).permit(:name)#Requires top level key :category & white lists the :name. 
  end
  
  def require_admin
    if !logged_in? || (logged_in? && !current_user.admin?)#If not(!) logged in or logged in & current_user is not admin.
      flash[:danger] = "Only admins can perform that action"
      redirect_to categories_path
    end
  end
end