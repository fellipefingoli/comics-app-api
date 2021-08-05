module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :find_user
  end

  def find_user
    @user = User.find_by(id: session[:user_id])
  end
end
