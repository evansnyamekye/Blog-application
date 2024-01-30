class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(:author, :comments).where(author_id: @user)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.includes(:comments, :likes).find_by(author_id: @user, id: params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post saved successfully'
      redirect_to user_posts_path(current_user)
    else
      flash.now[:error] = 'Error: Post could not be saved'
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    user = User.find_by(id: post.author_id)
    user.posts_counter -= 1
    post.destroy
    user.save
    redirect_to user_posts_path(user.id)
    flash[:success] = 'Post Deleted!'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
