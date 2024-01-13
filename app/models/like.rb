class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :user_id, uniqueness: { scope: :post_id }

  after_create :increment_likes_counter
  after_destroy :decrement_likes_counter

  after_save :update_post_likes_counter

  private

  def increment_likes_counter
    post.increment!(:likes_counter)
  end

  def decrement_likes_counter
    post.decrement!(:likes_counter)
  end

  def update_post_likes_counter
    post.update(likes_counter: post.likes_counter.to_i + 1)
  end
end
