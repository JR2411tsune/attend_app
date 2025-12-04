class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  def new
  end

  def create
    user = User.find_by(student_no: params[:student_no])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_index_path, notice: "ログインに成功しました。"
    else
      flash.now[:alert] = "学籍番号、またはパスワードが正しくありません。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "ログアウトしました。"
  end
end
