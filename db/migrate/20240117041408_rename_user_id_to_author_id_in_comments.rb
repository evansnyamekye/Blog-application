class RenameUserIdToAuthorIdInComments < ActiveRecord::Migration[7.1]
  def change
    rename_column :comments, :user_id, :author_id
  end
end
