class Auth::GoogleController < ApplicationController
  skip_before_action :login_required, only: :create

  def create
    user = User.find_by(email: auth.info.email)
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました。"
    else
      redirect_to login_path
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
