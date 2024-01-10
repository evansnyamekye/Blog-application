class AddAuthorIdToPosts < ActiveRecord::Migration[7.1]
  def change
    # add_reference :posts, :author, foreign_key: true
  end
end
