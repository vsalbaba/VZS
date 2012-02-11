# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Group.create( :ident => 'outsider', :name => 'Nečlen' )
Group.create( :ident => 'member', :name => 'Člen' )
Group.create( :ident => 'board', :name => 'Výbor' )
Group.create( :ident => 'admin', :name => 'Administrátor' )

