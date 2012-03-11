# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

puts "[Seeds] Creating default groups ..."
Group.find_or_create_by_ident('outsider', :name => 'Nečlen' )
Group.find_or_create_by_ident('member', :name => 'Člen' )
Group.find_or_create_by_ident('board', :name => 'Výbor' )
Group.find_or_create_by_ident('admin', :name => 'Administrátor' )
puts "[Seeds] Done."
