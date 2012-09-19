# encoding: UTF-8

FactoryGirl.define do
  factory :show do
    sequence(:name) {|n| "ukazka č. #{n}" }
    date Date.current
  end
end
