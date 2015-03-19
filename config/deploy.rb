set :application, 'mistery'
set :repo_url, 'git@github.com:tobymao/mistery.git'
set :deploy_to, "/home/deployer/apps/mistery"
set :tmp_dir, "/home/deployer/tmp"
set :ssh_options, {
  forward_agent: true,
  keys: ['/home/toby/.ssh/awskey.pem']
}

# Clean up all older releases
after "deploy:restart", "deploy:cleanup"

# This is where the actual deployment with Unicorn happens
namespace :deploy do
  desc 'Initiate a rolling restart by telling Unicorn to start the new application code and kill the old process when done.'
  task :restart do
    on roles :all do
      execute "kill -s USR2 `cat /tmp/unicorn.mistery.pid`"
    end
  end

  desc "Start the Unicorn process when it isn't already running."
  task :start do
    on roles :all do
      within "#{fetch(:deploy_to)}/current/" do
        execute :bundle, "exec unicorn -c config/unicorn.rb -D"
      end
    end
  end

  desc "Stop unicorn"
  task :stop do
    on roles :all do
      execute "kill -s QUIT `cat /tmp/unicorn.mistery.pid`"
    end
  end
end
