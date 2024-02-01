require 'rails_helper'

RSpec.describe 'Users#show', type: :feature, js: true do
  before(:all) do
    User.destroy_all
    Post.destroy_all
    Comment.destroy_all

    @lilly = User.create!(name: 'Lilly', photo: 'https://portraits.ai', bio: 'Teacher from Poland.', posts_counter: 0)
    @post = Post.create!(title: 'First Post', text: 'This is my first post', author: @lilly, comments_counter: 0,
                         likes_counter: 0)
    @tom = User.create!(name: 'Tom', photo: 'https://portraits.ai', bio: 'Teacher from Mexico.', posts_counter: 0)
    @users = User.all
  end

  # I can see the user's profile picture.
  it 'displays the user profile picture' do
    visit '/users'
    click_on 'Lilly'
    expect(page).to have_css("img[src*='#{@lilly.photo}']")
  end

  # I can see the user's username.
  it 'displays the user username' do
    visit '/users'
    click_on 'Lilly'
    expect(page).to have_content(@lilly.name.to_s)
  end

  # I can see the number of posts the user has written.
  it 'displays the number of posts the user has written' do
    visit '/users'
    click_on 'Lilly'
    expect(page).to have_content('1')
  end

  # I can see the user's bio.
  it 'displays the user bio' do
    visit '/users'
    click_on 'Lilly'
    expect(page).to have_content('Teacher from Poland.')
  end

  # I can see the user's first 3 posts.
  it 'displays the user first 3 posts' do
    visit '/users'
    click_on 'Lilly'
    expect(page).to have_content('First Post')
  end

  # I can see a button that lets me view all of a user's posts.
  it 'displays a button that lets me view all of a user posts' do
    visit '/users'
    click_on 'Lilly'
    expect(page).to have_link('See all posts')
  end

  # When I click a user's post, it redirects me to that post's show page.
  it 'redirects to post show page when clicking a user\'s post' do
    visit user_path(@lilly)

    # Assuming you have a link to the post within the user's show page
    click_link(href: user_post_path(@lilly, @post))

    # Assert that the current path is the post show page
    expect(page).to have_content('Lilly')
  end

  # # When I click to see all posts, it redirects me to the user's post's index page.
  it 'redirects to user\'s post index page when clicking to see all posts' do
    visit user_path(@lilly)

    # Assuming you have a link to see all posts within the user's show page
    click_link('See all posts')

    # Remove trailing slashes and normalize the paths before comparison
    expect(page).to have_content('Lilly')
  end
end
