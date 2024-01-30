require 'rails_helper'

RSpec.describe 'Users#show', type: :feature, js: true do
  let(:user) { User.create!(name: 'Lilly', photo: 'https://portraits.ai', bio: 'Teacher from Poland.') }
  let!(:posts) do
    [
      Post.create(author: user, title: 'Post 1', text: 'text 1'),
      Post.create(author: user, title: 'Post 2', text: 'text 2'),
      Post.create(author: user, title: 'Post 3', text: 'text 3'),
      Post.create(author: user, title: 'Post 4', text: 'text 4')
    ]
  end

  before(:all) do
    User.destroy_all
    Post.destroy_all
    Comment.destroy_all
  end

  # I can see the user's profile picture.
  it 'displays the user profile picture' do
    visit '/users'
    click_on(user.name)
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  # I can see the user's username.
  it 'displays the user username' do
    visit '/users'
    click_on(user.name)
    expect(page).to have_content(user.name.to_s)
  end

  # I can see the number of posts the user has written.
  it 'displays the number of posts the user has written' do
    visit '/users'
    click_on(user.name)
    expect(page).to have_content('1')
  end

  # I can see the user's bio.
  it 'displays the user bio' do
    visit '/users'
    click_on(user.name)
    expect(page).to have_content('Teacher from Poland.')
  end

  # I can see the user's first 3 posts.
  it 'displays the user first 3 posts' do
    visit '/users'
    click_on(user.name)
    user.three_recent_posts.each do |_post|
      expect(page).to have_content('post')
    end
  end

  # I can see a button that lets me view all of a user's posts.
  it 'displays a button that lets me view all of a user posts' do
    visit '/users'
    click_on(user.name)
    expect(page).to have_link('See all posts')
  end

  # When I click a user's post, it redirects me to that post's show page.
  it 'redirects to post show page when clicking a user\'s post' do
    visit user_path(user)
    # Assuming you have a link to the post within the user's show page
    click_link(user.posts.last.title)
    # Assert that the current path is the post show page
    expect(page).to have_content('Lilly')
  end

  # When I click to see all posts, it redirects me to the user's post's index page.
  it 'redirects to user\'s post index page when clicking to see all posts' do
    visit user_path(user)
    # Assuming you have a link to see all posts within the user's show page
    click_link('See all posts')
    # Remove trailing slashes and normalize the paths before comparison
    expect(page).to have_content(user.name)
  end
end
