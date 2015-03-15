# config/unicorn.rb
env = ENV["RAILS_ENV"] || "development"
app_path = File.expand_path(File.dirname(__FILE__) + '/..')
worker_processes (env == 'production' ? 4 : 1)
timeout 15

preload_app true

if env == "development"
  listen(3000, backlog: 64)

  #Set the working directory of this unicorn instance.
  working_directory app_path

  # Set the location of the unicorn pid file. This should match what we put in the
  # unicorn init script later.
  pid app_path + '/tmp/unicorn.pid'

  # You should define your stderr and stdout here. If you don't, stderr defaults
  # to /dev/null and you'll lose any error logging when in daemon mode.
  stderr_path app_path + '/log/unicorn.log'
  stdout_path app_path + '/log/unicorn.log'
elsif env == "production"
  # listen on both a Unix domain socket and a TCP port,
  # we use a shorter backlog for quicker failover when busy
  listen "/tmp/mistery.socket", :backlog => 64

  pid "/tmp/unicorn.mistery.pid"

  # Help ensure your application will always spawn in the symlinked
  # "current" directory that Capistrano sets up.
  working_directory "/home/deployer/apps/mistery/current"

  # feel free to point this anywhere accessible on the filesystem
  user 'deployer', 'staff'
  shared_path = "/home/deployer/apps/mistery/shared"

  stderr_path "#{shared_path}/log/unicorn.stderr.log"
  stdout_path "#{shared_path}/log/unicorn.stdout.log"
end

# Garbage collection settings.
GC.respond_to?(:copy_on_write_friendly=) &&
  GC.copy_on_write_friendly = true

# If using ActiveRecord, disconnect (from the database) before forking.
before_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "/tmp/unicorn.mistery.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

# After forking, restore your ActiveRecord connection.
after_fork do |server, worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
