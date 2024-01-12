require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Omar') }
  before { subject.save }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not(be_valid)
  end

  it "shouldn't have any recent posts" do
    expect(subject.recent_posts.length).to eq(0)
  end

  it 'should have a positive posts counter' do
    subject.posts_counter = -1
    expect(subject).to_not(be_valid)
  end

  it 'should have a positive posts counter' do
    subject.posts_counter = -1
    expect(subject).to_not(be_valid)
  end

  it 'displays three recent posts when called' do
    4.times do |i|
      post = subject.posts.create(title: "Post #{i}")
      post.save
    end
    expect(subject.posts.length).to eq(4)
  end

  it 'should display posts created by user' do
    user = User.create(name: 'User')
    2.times do |i|
      post = user.posts.create(title: "Post #{i}", text: "Text #{i}")
      post.save
    end
    expect(user.posts.length).to eq(2)
  end
end
