# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comics', type: :request do
  let(:headers) { { 'ACCEPT' => 'application/json' } }
  let(:response_body) { JSON.parse(response.body) }

  describe 'GET /index' do
    let(:params) { { format: 'comic', limit: 25, orderBy: '-onsaleDate' } }

    context 'when request is successful' do
      before do
        VCR.use_cassette('get_index_comics', record: :all) do
          get '/comics', params: params, headers: headers
        end
      end

      it 'returns a list of comics' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:ok)
        expect(response_body['comics']).to be_an_instance_of(Array)
        expect(response_body['comics'].first).to have_key('id')
        expect(response_body['comics'].first).to have_key('title')
      end

      it 'returns the right attributes' do
        expect(response_body['comics'].first).to have_key('description')
        expect(response_body['comics'].first).to have_key('price')
        expect(response_body['comics'].first).to have_key('thumbnail')
        expect(response_body['comics'].first).to have_key('date')
        expect(response_body['comics'].first).to have_key('liked')
      end
    end

    context 'when raise a error' do
      before do
        allow(Marvel::Repository::Comic).to receive(:get).with(any_args).and_raise(StandardError, 'error')
        get '/comics', params: params, headers: headers
      end

      it 'returns a error message' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:internal_server_error)
        expect(response_body['error']['code']).to eq(500)
        expect(response_body['error']['message']).to eq('error')
      end
    end
  end

  describe 'PUT /like' do
    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { user_id: user.id } }
    end

    context 'when user like a comic' do
      let(:params) { { liked: true } }
      let(:user) { create(:user) }

      before do
        put "/comics/1/like", params: params, headers: headers
      end

      it 'create a new user_marvel_comics with like true' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:ok)
        expect(response_body['comic']['id']).to eq(1)
        expect(response_body['comic']['liked']).to be_truthy
      end
    end

    context 'when user dislikes a comic' do
      let(:params) { { liked: false } }
      let(:user) { create(:user) }

      before do
        put "/comics/1/like", params: params, headers: headers
      end

      it 'create a new user_marvel_comics with like true' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:ok)
        expect(response_body['comic']['id']).to eq(1)
        expect(response_body['comic']['liked']).to be_falsey
      end
    end

    context 'when request raise an error' do
      let(:params) { { liked: true } }
      let(:user) { create(:user) }

      before do
        allow_any_instance_of(UserMarvelComic).to receive(:update!).and_raise(ActiveRecord::ActiveRecordError, 'error')
        put "/comics/1/like", params: params, headers: headers
      end

      it 'create a new user_marvel_comics with like true' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:internal_server_error)
        expect(response_body['error']['code']).to eq(500)
        expect(response_body['error']['message']).to eq('error')
      end
    end
  end
end
