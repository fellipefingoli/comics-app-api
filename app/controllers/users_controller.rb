# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, only: [:login]

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render :create, status: :created
    else
      render :create, status: :unprocessable_entity
    end
  end

  def login
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      render :login, status: :ok
    else
      render :login, status: :unauthorized
    end
  end

  def logout
    session[:user_id] = nil
    render :logout, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find_by(email: params[:email])
  end
end
