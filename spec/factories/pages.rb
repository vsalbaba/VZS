# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    title "MyString"
    menu_title "MyString"
    content "MyText"
    navbar false
    menu false
  end
end
