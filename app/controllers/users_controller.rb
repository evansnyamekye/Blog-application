class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  
  def generate_token
    @user = User.find(current_user.id)
    @user.generate_token
    if @user.save
      flash[:success] = 'Token generated successfully'
    else
      flash[:error] = 'Error: Token could not be generated'
    end
    redirect_to user_path(@user)
  end
end
