class SessionsController < ApplicationController
  def new
  end
  def create
    if params[:session][:email].blank? || params[:session][:password].blank?
      flash.now[:alert] = "Email and Password are required."
      render :new, status: :unprocessable_entity
    else
      user = User.find_by(email: params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to categories_path, notice: "Logged in successfully!"
      else
        flash.now[:alert] = "Invalid email or password."
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
