require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(text: 'This is my first comment') }
  before { subject.save }

  it 'comments_counter method should raise error without post' do
    expect { subject.comments_counter }.to raise_error(NoMethodError)
  end

  it 'check user presence' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'check post presence' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'check text presence' do
    subject.text = nil
    expect(subject).to_not be_valid
  end
end
