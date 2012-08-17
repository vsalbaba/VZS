FactoryGirl.define do
  factory :profile do
    user 
    first_name 'rspec'
    second_name 'user'
    sequence(:email) { |n| "user_${n}@example.org" }
    telephone '123456789'
    birthdate '2011-01-01'
    birthnumber '110101/2222'
    address

    factory :profile_for_member do
      association :user, :factory => :user_member
    end
  end
end
