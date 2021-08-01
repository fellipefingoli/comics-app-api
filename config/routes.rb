# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: [:create] do
    collection do
      post 'login'
    end
  end
end
