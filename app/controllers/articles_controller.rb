class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  
  def create
    #render plain: params[:article].inspect - Used as a test
    @article = Article.new(article_params)
    @article.save
    redirect_to articles_show(@article)#The text lecture says: redirect_to article_path(@article)
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :description)#(:article) is the 'top level key'
  end

end