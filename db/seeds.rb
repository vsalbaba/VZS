# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)


admin_address = Address.create()

admin_profile = Profile.create(
  :first_name => 'Admin',
  :second_name => 'Administrátor',
  :email => 'admin@example.org',
  :address => admin_address
)

admin = User.create(
  :login => 'admin',
  :group => User::GROUP[:ADMIN],
  :password => 'admin',
  :password_confirmation => 'admin',
  :profile => admin_profile
)
