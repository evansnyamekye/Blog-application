require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Evans') }
  before { subject.save }

  it 'name must not be blank' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter must be an integer' do
    subject.posts_counter = 'rice'
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be greater than or equal to 0' do
    subject.posts_counter = 0
    subject.posts_counter = -5
    expect(subject).to_not be_valid
  end

  it 'returns no more than 3 posts' do
    user = User.create(name: 'name', photo: 'url', bio: 'bio', posts_counter: 0)
    Post.create(author_id: user.id, title: 'post', text: 'text', likes_counter: 0, comments_counter: 0)
    Post.create(author_id: user.id, title: 'post', text: 'text', likes_counter: 0, comments_counter: 0)
    Post.create(author_id: user.id, title: 'post', text: 'text', likes_counter: 0, comments_counter: 0)
    Post.create(author_id: user.id, title: 'post', text: 'text', likes_counter: 0, comments_counter: 0)
    recent_posts = user.three_recent_posts
    expect(recent_posts).to eq(user.posts.last(3))
  end
end
