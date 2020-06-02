class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed in."
      redirect_to articles_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if (@user.update(user_params))
      flash[:notice] = "Your information was updated"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
