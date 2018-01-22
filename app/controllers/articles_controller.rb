class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    # Extracted to set_article under private
  end
  
  def create
    #render plain: params[:article].inspect - Used as a test
    @article = Article.new(article_params)
    @article.user = User.first#Temporarily hard codes the user association to the article.
    if @article.save
      flash[:success] = "Article was created successfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def update
    # Extracted to set_article under private
    if @article.update(article_params)
      flash[:success] = "The article was successfully updated."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def show
    # Extracted to set_article under private
  end
  
  def destroy
    # Extracted to set_article under private
    @article.destroy
    flash[:danger] = "Article was successfully deleted."
    redirect_to articles_path
  end
  
  private
  
  def set_article
    @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :description)#(:article) is the 'top level key'
  end

end