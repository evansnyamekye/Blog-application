require 'rails_helper'

RSpec.describe 'Posts#show', type: :system do
  before(:all) do
    Comment.delete_all
    Post.delete_all
    User.delete_all
    def url_for_image
      'https://images.unsplash.com/photo-1552058544-f2b08422138a?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTZ8fHBvcnRyYWl0fGVufDB8fDB8fHww'
    end

    @tom = User.create(name: 'Tom', photo: url_for_image, bio: 'Teacher from Mexico.', posts_counter: 0)
    @first_post = Post.create(author: @tom, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                              likes_counter: 0)
    @lilly = User.create(name: 'Lilly', photo: url_for_image, bio: 'Teacher from Poland.',
                         posts_counter: 0)
    @second_post = Post.create(author: @lilly, title: 'Title', text: 'Lets talk', comments_counter: 0,
                               likes_counter: 0)
    Comment.create(post: @first_post, user: @lilly, text: 'Hi Tom!')
    Comment.create(post: @second_post, user: @tom, text: 'Hi Lilly!')
    @users = User.all
    @posts = Post.all
  end

  #   I can see the post's title.
  it 'displays the post title' do
    visit user_post_path(@lilly, @second_post)
    expect(page).to have_content('Post#')
  end
  #   I can see who wrote the post.
  it 'displays the post author' do
    visit user_post_path(@lilly, @second_post)
    expect(page).to have_content('Lilly')
  end
  #   I can see how many comments it has.
  it 'displays the number of comments' do
    visit user_post_path(@lilly, @second_post)
    expect(page).to have_content('1')
  end
  #   I can see how many likes it has.
  it 'displays the number of likes' do
    visit user_post_path(@lilly, @second_post)
    expect(page).to have_content('0')
  end
  #   I can see the post body.
  it 'displays the post body' do
    visit user_post_path(@lilly, @second_post)
    expect(page).to have_content('Lets talk')
  end

  #   I can see the username of each commentor.
  it 'displays the username of each commentor' do
    visit user_post_path(@tom, @second_post)
    expect(page).to have_content('Tom')
  end

  #   I can see the comment each commentor left.
  it 'displays the comment each commentor left' do
    visit user_post_path(@lilly, @second_post)
    expect(page).to have_content('Hi Lilly!')
  end
end
