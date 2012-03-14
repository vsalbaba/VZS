FactoryGirl.define do
  factory :user do
    sequence(:login) {|n| "user#{n}"}
    password 'ahoj'
    password_confirmation 'ahoj'
    group
  end
end
