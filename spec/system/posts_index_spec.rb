require 'rails_helper'

describe 'Post Index Page Features', type: :feature, js: true do
  let(:user) do
    User.create(
      name: 'Harley Quinn',
      photo: 'https://images.unsplash.com/photo-1552058544-f2b08422138a?w=700',
      bio: 'user Pix'
    )
  end

  let!(:posts) do
    [
      Post.create(author: user, title: 'Post 1', text: 'text 1'),
      Post.create(author: user, title: 'Post 2', text: 'text 2'),
      Post.create(author: user, title: 'Post 3', text: 'text 3'),
      Post.create(author: user, title: 'Post 4', text: 'text 4')
    ]
  end

  let!(:comments) do
    [
      Comment.create(user:, text: 'comment 1', post: user.posts.first),
      Comment.create(user:, text: 'comment 2', post: user.posts.first),
      Comment.create(user:, text: 'comment 3', post: user.posts.first)
    ]
  end

  before :each do
    Like.create(user:, post: user.posts.first)
    visit user_posts_path(user)
  end

  # I can see the user's profile picture.
  it 'can see the user\'s profile picture' do
    expect(page).to have_css("img[src='#{user.photo}']")
  end

  # I can see the user's username
  it 'can see the user\'s username' do
    expect(page).to have_content('Harley Quinn')
  end

  # I can see the number of posts the user has written.
  it 'can see the number of posts the user has written' do
    expect(page).to have_content(user.posts_counter)
  end

  # I can see a post's title.
  it 'can see the post\'s title' do
    posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  # I can see some of the post's body.
  it 'can see the post\'s body' do
    posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  # I can see the first comments on a post
  it 'can see the first comments of a post' do
    posts.each do |post|
      post.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end

  # I can see how many comments a post has.
  it 'can see how many comments a post has' do
    expect(page).to have_content(user.posts_counter)
  end

  # I can see how many likes a post has.
  it 'can see how many likes a post has' do
    posts.each do |post|
      expect(page).to have_content(post.likes_counter)
    end
  end
  # I can see a section for pagination if there are more posts than fit on the view.
  it 'can see a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_link('Pagination')
  end
  # When I click on a post, it redirects me to that post's show page.
  it 'When I click on a post, it redirects me to that post\'s show page' do
    click_link(user.posts.first.title)
    expect(page).to have_content(user.name)
  end
end
