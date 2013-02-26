# -*- encoding : utf-8 -*-
require './config/deploy_cap_db.rb'
#require 'capistrano_colors'
require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, "vzs"

set :scm, :git
set :repository,  "git@github.com:friendlysystems/VZS.git"
set :deploy_via, :remote_cache

set :rvm_type, :system
set :rvm_ruby_string, "1.9.2"

desc "Echoes server's uname"
task :uname do
  run "uname -a"
end

namespace :deploy do
  namespace :db do
    desc "Seed initial database data"
    task :seed do
      rake = fetch(:rake, "rake")
      rails_env = fetch(:rails_env, "production")
      migrate_env = fetch(:migrate_env, "")
      migrate_target = fetch(:migrate_target, :latest)

      directory = case migrate_target.to_sym
                  when :current then current_path
                  when :latest  then latest_release
                  else raise ArgumentError, "unknown migration target #{migrate_target.inspect}"
                  end

      run "cd #{directory} && #{rake} RAILS_ENV=#{rails_env} #{migrate_env} db:seed"
      #run "#{default_shell} rake db:seed"
    end
  end
end

after "deploy:migrate", "deploy:db:seed"

