class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :likes]
  def index
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.order(id: :desc).page(params[:page])
    end
  end

  def show
     @user = User.find(params[:id])
     @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def  update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'ユーザ情報を更新しました'
      redirect_to @user
    else
      flash[:danger] = 'ユーザ情報の更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    @user = User.find_by(id: params[:id])
    @posts = Post.find_by(user_id: params[:id])
    flash[:success] = "Friendsから退会しました"
    
    if @posts.nil?
      @user.destroy
      redirect_to root_url
    else
      @posts.destroy
      @user.destroy
      redirect_to root_url
    end
  end
  
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
    counts(@user)
  end
  
  private
  def user_search_params
    params.fetch(:search, {}).permit(:name)
  end
  
  def user_params
    params.require(:user).permit(:icon, :name, :email, :password, :password_confirmation, :content)
  end
  
end
