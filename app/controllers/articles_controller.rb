class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def show
    #byebug
    #instance variable @article is available generally for the whole controller
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  # Action
  def create
    #render plain: params[:article] #loads as plain text
    #render plain: @article.inspect

    #white list, strong params security introduced in RoR 6
    @article = Article.new(get_article_params)
    @article.user = User.first
    if @article.save {
      flash[:notice] = "Article was created successfully."
      #redirect to show, it extracts the article id automatically
      redirect_to article_path(@article) #redirect_to @article
    }
    else
      render "new" #renders the new view again
    end
  end

  def edit
  end

  # Action
  def update
    if @article.update(get_article_params)
      flash[:notice] = "Article was updated succesfully"
      redirect_to @article
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def get_article_params
    params.require(:article).permit(:title, :description)
  end
end
