class ApplicationController < ActionController::Base
  allow_browser versions: :modern  # ← 残す（古いブラウザを弾く）
  before_action :require_login

  private

  def not_authenticated
    redirect_to root_path, alert: "ログインが必要です"
  end
end
