# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  describe 'POST /create' do
    let(:email) { Faker::Internet.unique.email }

    before do
      post '/users', params: params, headers: headers
    end

    context 'when user params are valid' do
      let(:params) do
        {
          user: {
            email: email,
            password: 'some_strong_password',
            password_confirmation: 'some_strong_password'
          }
        }
      end

      let(:success_response_body) do
        {
          user: {
            email: email
          }
        }
      end

      it 'creates a new user' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:created)
        expect(response.body).to eq(success_response_body.to_json)
        expect(User.count).to eq(1)
      end
    end

    context 'when user params are invalid' do
      let(:params) do
        {
          user: {
            email: email,
            password: 'some_strong_password',
            password_confirmation: 'another_password'
          }
        }
      end

      let(:failed_response_body) do
        {
          user: {
            email: email,
            errors: {
              password_confirmation: ["doesn't match Password"]
            }
          }
        }
      end

      it 'does not creates a new user' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq(failed_response_body.to_json)
        expect(User.count).to eq(0)
      end
    end
  end

  describe 'POST /login' do
    let(:user) { create(:user) }

    before do
      post '/users/login', params: params, headers: headers
    end

    context 'when credentials are valid' do
      let(:params) do
        {
          email: user.email,
          password: 'some_strong_password'
        }
      end

      let(:success_response_body) do
        {
          user: {
            email: user.email
          }
        }
      end

      it 'creates a new user session' do
        expect(session[:user_id]).to be_present
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(success_response_body.to_json)
      end
    end

    context 'when credentials are invalid' do
      let(:params) do
        {
          email: user.email,
          password: 'wrong_password'
        }
      end

      it 'does not creates a new user session' do
        expect(session[:user_id]).to be_nil
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq('{}')
      end
    end
  end

  describe 'GET /logout' do
    let(:user) { create(:user) }

    before do
      get '/users/logout', headers: headers
    end

    it do
      expect(session[:user_id]).to be_nil
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq('{}')
    end
  end
end
