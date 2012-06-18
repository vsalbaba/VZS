require 'csv'
namespace :import do 
  desc "Perform a rolling update of all feeds"
  task :users, [:csv_filename] => [:environment] do |t, args|

    csv_file = CSV.read args[:csv_filename]
    column_names = csv_file.first
    columns = {}
    column_names.each_with_index do |e, i|
      columns[e] = i
    end
    puts columns.inspect
    puts csv_file.first.inspect
    puts csv_file[2].inspect
    csv_file[1..-1].each do |user_line|
      if user_line[columns['Clen']] == "1" then
        user = User.find_or_create_by_login(user_line[columns['Id']]) do |user|
          user.password = user.password_confirmation = user_line[columns['Rc']]
          user.group = 1
        end
        user.save
        profile = user.build_profile
        profile.first_name = user_line[columns['Jmeno']]
        profile.second_name = user_line[columns['Prijmeni']]
        profile.email = user_line[columns['Email1']]
        profile.telephone = user_line[columns['Tel1']]
        profile.birthdate = Date.parse(user_line[columns['Narozeni']].to_s)
        profile.birthnumber = user_line[columns['Rc']]
        puts profile.inspect unless profile.valid?
        address = profile.build_address
        address.city = user_line[columns['Mesto']]
        address.postcode = user_line[columns['Psc']]
        address.street = user_line[columns['Ulice']]
        address.house_number = '0'
        address.save
      end
    end
  end
end
