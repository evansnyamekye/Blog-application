require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'User') }
  before { subject.save }

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'User shoud be present' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'is valid with a title and other attributes' do
    expect(subject).to_not be_valid
  end

  it 'is not valid with a title longer than 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'is not valid with a comments_counter less than 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is not valid with a likes_counter less than 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is not valid with a comments_counter not an integer' do
    subject.comments_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'checks that likes_counter is an integer' do
    subject.likes_counter = 1.5
    expect(subject).to_not be_valid
  end

  it 'is not valid with a likes_counter not an integer' do
    subject.likes_counter = 'sum'
    expect(subject).to_not be_valid
  end

  it 'comments_counter must be an interger' do
    subject.comments_counter = 'Man'
    expect(subject).to_not be_valid
  end

  it 'comments_counter and likes_counter should be greater than 0' do
    subject.comments_counter = -5
    subject.likes_counter = -5
    expect(subject).to_not be_valid
  end

  it 'return an empty array if there are no comments' do
    result = subject.five_most_recent_comments
    expect(result).to eq([])
  end
end
