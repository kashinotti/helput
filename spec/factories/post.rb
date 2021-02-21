FactoryBot.define do
  factory :post do
    title { "投稿テスト" }
    content { "投稿テストです" }
    # association :user, factory: :user
  end
end