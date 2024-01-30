require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:id/posts' do
    it 'returns http success' do
      get '/users/2/posts'
      expect(response).to have_http_status(:success)
    end

    it 'returns success response 200' do
      get '/users/2/posts'
      expect(response).to have_http_status(200)
    end

    it 'returns body within the page' do
      get '/users/2/posts'
      expect(response.body).to include('Hey! Guys, this is my post')
    end

    it 'returns template' do
      get '/users/2/posts'
      expect(response).to render_template('posts/index')
    end
  end

  describe 'GET /users/:id/posts/:id' do
    it 'returns http success' do
      get '/users/2/posts/1'
      expect(response).to have_http_status(:success)
    end

    it 'returns success response 200' do
      get '/users/2/posts/1'
      expect(response).to have_http_status(200)
    end

    it 'returns body within the page' do
      get '/users/2/posts/1'
      expect(response.body).to include('Posts#show')
    end

    it 'returns template' do
      get '/users/2/posts/1'
      expect(response).to render_template('posts/show')
    end
  end
end
