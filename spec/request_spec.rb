require_relative 'spec_helper'

describe Bowling do
  describe 'GET /' do
    it 'is successful' do
      get '/'
      expect(last_response.status).to eq 200
    end
  end

  describe 'GET /new' do
    it 'is successful' do
      get '/new'
      expect(last_response.redirect?).to eq true
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end

  describe 'POST /' do
    it 'is successful' do
      post '/', score: "5"
      expect(last_response.redirect?).to eq true
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end
end
