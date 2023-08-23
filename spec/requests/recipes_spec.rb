require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET /' do
    before do
      FactoryBot.create_list(:recipe, 5)
      get '/recipes'
    end
    
    it 'returns all recipes' do
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end