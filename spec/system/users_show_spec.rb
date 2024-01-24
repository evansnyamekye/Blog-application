require 'rails_helper'

RSpec.describe 'Users#show', type: :system do
  before(:all) do
    User.destroy_all
    Post.destroy_all
    Comment.destroy_all

    @lilly = User.create!(name: 'Lilly', photo: 'https://portraits.ai', bio: 'Teacher from Poland.', posts_counter: 0)
    Post.create!(title: 'First Post', text: 'This is my first post', author: @lilly, comments_counter: 0,
                 likes_counter: 0)
    @tom = User.create!(name: 'Tom', photo: 'https://portraits.ai', bio: 'Teacher from Mexico.', posts_counter: 0)
    @users = User.all
  end

  # I can see the user's profile picture.
  it 'displays the user profile picture' do
    visit '/users'
    click_on 'Lilly'
    expect(page).to have_css("img[src*='https://portraits.ai']")
  end

  # I can see the user's username.
  it 'displays the user username' do
    visit '/users'
    click_on 'Lilly'
    expect(page).to have_content('Lilly')
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
    expect(page).to have_content('Show Posts')
  end

  # When I click a user's post, it redirects me to that post's show page.
  it 'redirects to post show page when clicking a user\'s post' do
    visit user_path(@lilly)

    # Assuming you have a link to the post within the user's show page
    click_link 'First Post'

    # Assert that the current path is the post show page
    expect(current_path).to eq(user_post_path(@lilly, @lilly.posts.first))
  end

  # # When I click to see all posts, it redirects me to the user's post's index page.
  it 'redirects to user\'s post index page when clicking to see all posts' do
    visit user_path(@lilly)

    # Assuming you have a link to see all posts within the user's show page
    click_link 'Show Posts'

    # Remove trailing slashes and normalize the paths before comparison
    expected_path = user_posts_path(@lilly).chomp('/')
    actual_path = current_path.chomp('/')

    expect(actual_path).to eq(expected_path)
  end
end
