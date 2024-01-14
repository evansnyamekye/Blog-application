class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id]) # params[:id] is the id of the user that we want to show
  end
end
