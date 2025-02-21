class SessionsController < ApplicationController

  def new
  end
  def create
    if params[:session][:email].blank? || params[:session][:password].blank?
      render :new, status: :unprocessable_entity
    else
      user = User.find_by(email: params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to categories_path
      else
        flash.now[:alert] = "Invalid email or password."
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  
end
