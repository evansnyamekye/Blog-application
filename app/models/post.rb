class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes
  belongs_to :user, counter_cache: true

  after_save :update_posts_counter

  validates :title, presence: true, length: { minimum: 250 }
  validates :comments_counter, :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_user_posts_counter
    user.increment!(:posts_counter)
  end

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
