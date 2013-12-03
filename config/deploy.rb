set :application, 'tour_planner'
set :repo_url, "git@github.com:benwilson512/tour_planner2.git"

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/u/apps/tour_planner'
set :default_stage, "production"
# set :scm, :git

set :linked_dirs, %w{deps}

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc "start application"
  task :start do
    on roles(:app) do
      within release_path do
        execute "cd #{release_path} && MIX_ENV=prod mix do compile, server --port 80 &"
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :killall, "beam"
      within release_path do
        execute "cd #{release_path} && MIX_ENV=prod mix do compile, server --port 80 &"
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end

namespace :deps do
  task :get do
    on roles(:app) do
      within release_path do
        execute :mix, "deps.get"
      end
    end
  end
  before 'deploy:updated', 'deps:get'
end
