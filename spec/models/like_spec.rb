require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { Like.new }
  before { subject.save }

  it 'like_counter method should raise an error without post' do
    expect { subject.like_counter }.to raise_error(NoMethodError)
  end

  it 'should increment the likes counter of the related post when saved' do
    user = User.create(name: 'User')
    Post.create(title: 'Post', text: 'Text', user:)
  end
end
