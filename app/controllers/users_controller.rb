class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit_password, :update_password]
  skip_before_action :check_password, only: [:edit_password, :update_password]

  def index
    @users = User.all
  end

  def edit_password
  end

  def update_password
    if @user.update(user_params)
      sign_in @user, bypass: true
      redirect_to root_path
    else
      render :edit_password
    end
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end