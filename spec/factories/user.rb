# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user do
    sequence(:login) {|n| "user#{n}"}
    password 'ahoj'
    password_confirmation 'ahoj'

    factory :user_member do
      group User::GROUP[:MEMBER]
    end
  end
end
