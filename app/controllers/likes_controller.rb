class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post: @post)

    respond_to do |format|
      if @like.save
        format.html { redirect_to user_post_path(@post.author, @post), notice: 'Like was successfully created.' }
      else
        format.html { redirect_to user_post_path(@post.author, @post), alert: 'Failed to create like.' }
      end
    end
  end
end
