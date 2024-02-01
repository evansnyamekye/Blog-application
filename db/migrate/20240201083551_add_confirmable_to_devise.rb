class AddConfirmableToDevise < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_index :users, :confirmation_token, unique: true
    # User.reset_column_information # Uncomment this line if your project requires it
    # User.all.update_all confirmed_at: DateTime.now # Uncomment this line if your project requires it
  end

  def down
    remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
