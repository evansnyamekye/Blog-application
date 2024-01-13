class AddPostsCountToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :posts_count, :integer
  end
end
