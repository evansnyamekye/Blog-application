require 'rails_helper'
RSpec.describe 'Users#index', type: :feature, js: true do
  before(:all) do
    User.destroy_all
    Post.destroy_all
    Comment.destroy_all
    @lilly = User.create!(name: 'Lilly', photo: 'https://portraits.ai', bio: '', posts_counter: 0)
    Post.create!(title: 'First Post', text: 'This is my first post', author: @lilly, comments_counter: 0,
                 likes_counter: 0)
    @tom = User.create!(name: 'Tom', photo: 'https://portraits.ai', bio: '', posts_counter: 0)
    @users = User.all
  end
  # I can see the username of all other users.
  it 'displays the names of all users' do
    visit '/users'
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end
  # I can see the profile picture for each user.
  it 'displays the profile picture for each user' do
    visit '/users'
    @users.each do |user|
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
  end
  # I can see the number of posts each user has written.
  it 'displays the number of posts each user has written' do
    visit '/users'
    @users.each do |user|
      expect(page).to have_content(user.posts_counter)
    end
  end
  # When I click on a user, I am redirected to that user's show page.
  it 'redirects to the user show page when a user is clicked' do
    visit '/users'
    click_on 'Lilly'
    expect(page).to have_current_path(user_path(@lilly))
  end
end
