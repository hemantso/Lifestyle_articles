class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_same_user, only: %i[edit update]
  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to articles_path
    else
      flash[:danger] = 'User was not created'
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User was successfully updated'
      redirect_to @user
    else
      flash[:danger] = 'User was not updated'
      render :edit
    end
  end

  def destroy
    if @user.destroy
    flash[:notice] = 'User was successfully deleted'
    redirect_to users_url
    else
      flash[:danger] = 'User was not deleted'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    return flash[:danger] = 'You can only edit your own account' unless current_user != @user
  end
end