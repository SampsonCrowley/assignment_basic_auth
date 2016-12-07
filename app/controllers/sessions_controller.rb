class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
    if signed_in_user?
      redirect_to user_path(current_user)
    end
  end

  def create
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success] = "Successfully signed in"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Sorry, you couldn't be signed in"
      render :new
    end
  end

  def destroy
    sign_out
    flash[:success] = "You have successfully signed out"
    redirect_to root_url
  end
end
