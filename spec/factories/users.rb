FactoryBot.define do
  factory :user do
    sequence(:email) { |_n| "email-#{srand}@example.edu" }
    password 'a password'
    password_confirmation 'a password'
  end
end
