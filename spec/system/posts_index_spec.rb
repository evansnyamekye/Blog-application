require 'rails_helper'

describe 'Post Index Page Features', type: :feature, js: true do
  before :each do
    @user1 = User.create(
      name: 'Harley Quinn',
      photo:  'https://images.unsplash.com/photo-1552058544-f2b08422138a?w=700',
      bio: 'user1 Pix',
      posts_counter: 5
    )

    post1 = Post.create( title: 'Post 1', text: 'text 1', likes_counter: 0, comments_counter: 0)
    post2 = Post.create( title: 'Post 2', text: 'text 2', likes_counter: 0, comments_counter: 0)
    Post.create( title: 'Post 3', text: 'text 3', likes_counter: 0, comments_counter: 0)
    Post.create( title: 'Post 4', text: 'text 4', likes_counter: 0, comments_counter: 0)

    @user1.comments.create(text: 'comment 1', post: post1)
    @user1.comments.create(text: 'comment 2', post: post1)
    @user1.comments.create(text: 'comment 3', post: post2)

    @user1.likes.create(post: post1)
  end

  # I can see the user's profile picture.
  it 'can see the user\'s profile picture' do
    visit user_posts_path(@user1.id)
    expect(page).to have_css('.comment-bio-card')
  end

  # I can see the user's username
  it 'can see the user\'s username' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Harley Quinn')
  end

  # I can see the number of posts the user has written.
  it 'can see the number of posts the user has written' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Post 1')
  end

  # I can see a post's title.
  it 'can see the post\'s title' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Post 1')
  end

  # I can see some of the post's body.
  it 'can see the post\'s body' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content(text)
  end

  # I can see the first comments on a post
  it 'can see the first comments of a post' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('comment 1')
  end

  # I can see how many comments a post has.
  it 'can see how many comments a post has' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content(@user1.posts_counter)
  end

  # I can see how many likes a post has.
  it 'can see how many likes a post has' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Likes: 1')
    expect(page).to have_content('Likes: 0')
  end
  # I can see a section for pagination if there are more posts than fit on the view.
  it 'can see a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(@user1.id)
    expect(page).to have_css('button')
  end
  # When I click on a post, it redirects me to that post's show page.
  it 'When I click on a post, it redirects me to that post\'s show page' do
    visit user_posts_path(@user1.id)
    click_link(href: user_post_path(@user1.id, 6666))
    expect(page).to have_current_path(user_post_path(@user1.id, 6666))
  end
end
