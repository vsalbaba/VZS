# -*- encoding : utf-8 -*-
###
### copy this file into config/deploy/your_server.rb and specify following options
###   your_server can be whatever you want 
###   you will use it to identify deploy target in capistrano execution as:
###   $ cap your_server deploy
###
### if you need, you can override here anything from config/deploy.rb
###

### uncomment if you want to use precompiled assets (production only!)
#load 'deploy/assets'

### specify your server
server "", :web, :app, :db, { :primary => true }

### or if you have separate machines:
#role :web, ""
#role :app, ""
#role :db,  "", :primary => true

### where this app will be deployed at tarteg machine (folder path)
### dont use "~" here or db/setup will fail
### use plain #{application} instead (home dir is base of this path)
### or better use absolute path
set :deploy_to, "#{application}"

### for ssh to target server
set :user, ""
set :password, ""
set :use_sudo, false

set :rails_env, :development

### usable to get full blown development/test set of gems
# set :bundle_without, []
# set :bundle_flags, "--quiet"
### and to keep gems only in rvm
# set :bundle_dir, ""

### use this for passenger (otherwise comment it out)
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

