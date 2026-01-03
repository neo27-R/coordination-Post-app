class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      redirect_to events_path, notice: "登録しました"
    else
      if @user.errors.added?(:password_confirmation, :confirmation)
        flash.now[:alert] = "パスワード（確認）が一致しません"
      else
        flash.now[:alert] = @user.errors.full_messages.first || "入力内容を確認してください"
      end

      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
