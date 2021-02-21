require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "投稿バリデーションテスト" do

    before "ユーザーファクトリを作成" do
      @user = FactoryBot.create(:user)
    end

    it "タイトルがなければ無効な状態であること" do
      
      post = @user.posts.create(
        title: nil,
        content: "投稿テストです"
      )
      post.valid?
      expect(post.errors[:title]).to include("を入力してください")
    end

    it "本文がなければ無効な状態であること" do
      post = @user.posts.create(
        title: "タイトルテストです",
        content: nil
      )
      expect(post.errors[:content]).to include("を入力してください")
    end

  end
end
