class Admins::HomesController < ApplicationController
  layout 'admins'
  before_action :authenticate_admin!
  def top
    # 現在のユーザー数と投稿数を確認できるようにするために変数を定義
    @users = User.all
    @posts = Post.all
  end
end
