module Authorizable
  extend ActiveSupport::Concern

  def authorize
    unless @user.present?
      render 'shared/unauthorized', status: :unauthorized
    end
  end
end
