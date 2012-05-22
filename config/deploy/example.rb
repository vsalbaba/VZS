#
# copy this file into config/deploy/your_server.rb and specify following options
#   your_server can be whatever you want 
#   you will use it to identify deploy target in capistrano execution as:
#   $ cap your_server deploy
#
# if you need, you can override here anything from config/deploy.rb
#

role :web, ""                          # Your HTTP server, Apache/etc
role :app, ""                          # This may be the same as your `Web` server
role :db,  "", :primary => true # This is where Rails migrations will run

# for ssh to target server
set :user, ""
set :password, ""
set :use_sudo, false

set :rails_env, :development

# usable to get full blown production/development stack
# set :bundle_without, []
# set :bundle_flags, "--quiet"
# and to keep gems only in rvm
# set :bundle_dir, ""

set :deploy_to, "~/#{application}"

# use this for passenger (otherwise comment it out)
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

