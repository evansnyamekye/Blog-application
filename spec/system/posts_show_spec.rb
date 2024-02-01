require 'rails_helper'

RSpec.describe 'Posts#show', type: :feature, js: true do
  let(:user) { User.create(name: 'Lilly', photo: 'https://images.unsplash.com/photo-1552058544-f2b08422138a?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTZ8fHBvcnRyYWl0fGVufDB8fDB8fHww', bio: 'Teacher from Poland.') }

  let(:post) { Post.create(author: user, title: 'Hello', text: 'This is my first post') }

  let!(:comments) do
    [
      Comment.create(post:, user:, text: 'Hi Tom!'),
      Comment.create(post:, user:, text: 'Hi Lilly!')
    ]
  end

  before :each do
    visit user_post_path(user, post)
  end

  #   I can see the post's title.
  it 'displays the post title' do
    expect(page).to have_content(post.title)
  end
  #   I can see who wrote the post.
  it 'displays the post author' do
    expect(page).to have_content(post.author.name)
  end
  #   I can see how many comments it has.
  it 'displays the number of comments' do
    expect(page).to have_content(post.comments.count)
  end
  #   I can see how many likes it has.
  it 'displays the number of likes' do
    expect(page).to have_content(post.likes_counter)
  end
  #   I can see the post body.
  it 'displays the post body' do
    expect(page).to have_content(post.text)
  end

  #   I can see the username of each commentor.
  it 'displays the username of each commentor' do
    comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  #   I can see the comment each commentor left.
  it 'displays the comment each commentor left' do
    comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
