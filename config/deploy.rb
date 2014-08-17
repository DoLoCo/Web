# config valid only for Capistrano 3.1
lock '3.2.1'

set :ssh_options, {
  user: 'deploy'
}

set :scm, :git
set :deploy_via, :remote_cache
set :application, 'DoLoCo'
set :repo_url, 'git@github.com:DoLoCo/Web.git'

set :stages, ['production']

set :deploy_to, '/home/deploy/www/doloco'

set :format, :pretty
set :pty, false # b/c sidekiq bug?

set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 5

set :rvm_ruby_version, 'ruby-2.1.2@doloco'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
