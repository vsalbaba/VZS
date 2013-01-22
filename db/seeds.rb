# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

puts "creating admin, with username admin, password admin"
admin = User.find_or_create_by_login(
  :login => 'admin',
  :password => 'admin',
  :password_confirmation => 'admin',
  :group => 3
)

admin_profile = Profile.find_or_create_by_user_id(
  admin.id,
  :first_name => 'Admin',
  :second_name => 'Adminovič',
  :email => 'admin@example.com',
  :telephone => '906060606',
  :birthdate => '1.1.2000',
  :birthnumber => '0123456789'
)

if admin_profile.address.nil?
  admin_address = Address.create( :street => 'street', :house_number => '0', :city => 'city', :postcode => 'psc' )
  admin_profile.address = admin_address
end

admin_profile.save

