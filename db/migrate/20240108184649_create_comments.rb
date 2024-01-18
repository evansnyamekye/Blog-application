class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :user
      t.references :post
      t.text :text
    
      t.timestamps
    end
  end
end
