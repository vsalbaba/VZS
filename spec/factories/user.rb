FactoryGirl.define do
  factory :user do
    login 'Ahoj'
    password 'ahoj'
    password_confirmation 'ahoj'
    group
  end
end
