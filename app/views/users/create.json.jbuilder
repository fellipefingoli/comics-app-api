# frozen_string_literal: true

json.user do
  json.email @user.email

  json.errors @user.errors.messages if @user.errors.to_a.present?
end
