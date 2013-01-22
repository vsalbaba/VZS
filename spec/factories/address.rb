# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :address do
    street 'ulice'
    house_number '34a'
    city 'Brno'
    postcode '67401'

    factory :address_for_member do
      association :profile, :factory => :profile_for_member
    end
  end

end
