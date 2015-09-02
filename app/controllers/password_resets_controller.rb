class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to login_url, notice: "Email sent with password reset instructions"
    else
      redirect_to login_url, notice: "The user does not exist"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      redirect_to root_url, notice: "Password has been reset"
    else
      render 'edit'
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
