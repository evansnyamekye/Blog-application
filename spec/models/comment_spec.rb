require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(text: 'Hello World') }
  before { subject.save }

  it 'comment_counter method should raise error without post' do
    expect { subject.comment_counter }.to raise_error(NoMethodError)
  end

  it 'should increment the comments counter of the related post when saved' do
    user = User.create(name: 'User')
    post = Post.new(title: "Post title#{'a' * 250}", text: 'Text', user:)
    post.author = user
    post.save!
    comment = post.comments.create(text: 'Comment', user:)
    comment.save
    post.reload
    expect(post.comments_counter).to eq(1)
  end
end
