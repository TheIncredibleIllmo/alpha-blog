class ArticlesController < ApplicationController
    def show
        #byebug
        #instance variable @article is available generally for the whole controller
        @article = Article.find(params[:id])
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
        @article = Article.new(params.require(:article).permit(:title, :description))
         
        if @article.save {
            flash[:notice] = "Article was created successfully."
            #redirect to show, it extracts the article id automatically
            redirect_to article_path(@article) #redirect_to @article
        }            
        else
            render 'new' #renders the new view again
        end
    end

    def edit
        @article = Article.find(params[:id])
    end
    
    # Action
    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description));
            flash[:notice] = "Article was updated succesfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to  articles_path
    end
end