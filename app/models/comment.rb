class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates :user, presence: true
  validates :text, presence: true

  after_create :increment_comments_counter
  after_destroy :decrement_comments_counter

  after_save :update_post_comments_counter

  private

  def increment_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_comments_counter
    post.decrement!(:comments_counter)
  end

  def update_post_comments_counter
    post.update(comments_counter: post.comments_counter.to_i + 1)
  end
end
