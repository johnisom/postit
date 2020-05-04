class SessionsController < ApplicationController
  before_action :require_user, only: :destroy

  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you've logged in!"
      redirect_to root_path
    else
      flash.now[:error] = 'There is something wrong with your username or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out."
    redirect_back(fallback_location: root_path)
  end
end
