require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { Like.new }
  before { subject.save }

  it 'likes_counter method should raise error without post' do
    expect { subject.likes_counter }.to raise_error(NoMethodError)
  end

  it 'check validity of post presence' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'check validity of user presence' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'check uniqueness of user_id and post_id' do
    like = Like.new(user_id: subject.user_id, post_id: subject.post_id)
    expect(like).to_not be_valid
  end
end
