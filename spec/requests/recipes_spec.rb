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

  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:my_recipe) { FactoryBot.build(:recipe) }

      before do
        post '/recipes', params: { recipe: {
          title: my_recipe.title,
          description: my_recipe.description
        } }
      end

      it 'returns the title' do
        expect(json['title']).to eq(my_recipe.title)
      end

      it 'returns the title' do
        expect(json['description']).to eq(my_recipe.description)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/recipes', params: { recipe: {
          title: '',
          description: ''
        } }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /update' do
    let!(:my_recipe) { FactoryBot.create(:recipe) }

    context 'with valid parameters' do
      let(:new_title) { 'new title' }
      let(:new_description) { 'new description' }

      before do
        put "/recipes/#{my_recipe.id}", params: { recipe: {
          title: new_title,
          description: new_description
        } }
      end

      it 'returns the new title' do
        expect(json['title']).to eq(new_title)
      end

      it 'returns the new description' do
        expect(json['description']).to eq(new_description)
      end

      it 'returns a ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      before do
        put "/recipes/#{my_recipe.id}", params: { recipe: {
          title: nil,
          description: ''
        } }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:recipe) { FactoryBot.create(:recipe) }

    before do
      delete "/recipes/#{recipe.id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
