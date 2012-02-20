FactoryGirl.define do
  factory :profile do
    user_id 1001
    first_name 'rspec'
    second_name '_user'
    email 'test@test.cz'
    street 'rs'
    city 'pec'
    telephone '888888888'
    postal_code '11102'
    house_number '1'
    birthdate 10.years.ago
    birthnumber '102816219'
  end
end
