FactoryBot.define do
  factory :user, aliases: [:owner] do
    name { "tester" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "aaaaaa" }
  end
end