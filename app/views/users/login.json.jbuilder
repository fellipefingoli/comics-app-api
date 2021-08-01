# frozen_string_literal: true

if session[:user_id].present?
  json.user do
    json.email @user.email
  end
end

