require 'rails_helper'

RSpec.describe User, type: :model do

  describe "ユーザーバリデーションテスト" do

    it "名前がなければ無効な状態であること" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors).to be_added(:name, :blank)
    end

    it "メールアドレスがなければ無効な状態であること" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors).to be_added(:email, :blank)
    end

    it "重複したメールアドレスで登録しようとしたら無効な状態であること" do
      FactoryBot.create(:user, email: "tester@example.com")
      user = FactoryBot.build(:user, email: "tester@example.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end

  end
end
