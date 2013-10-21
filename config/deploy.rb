set :application, "priveim.com"
set :repository,  "git@github.com:prive/prive-api.git"

set :keep_releases, 2
require 'bundler/capistrano'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/opt/apps/priveim"
set :deploy_via, :remote_cache
set :user, "deploy"
set :use_sudo, false
set :rails_env, "production"

set :scm, :git
set :branch, "master"
set :git_enable_submodules, 1

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared resources on each release - not used"
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/sensitive_settings.rb #{release_path}/config/sensitive_settings.rb"
    # run "cd #{release_path} && RAILS_ENV=production bundle exec whenever --update-crontab manager.ismack --set environment=production"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
after "deploy:update", "deploy:cleanup" 
after "deploy:create_symlink", "deploy:migrate"