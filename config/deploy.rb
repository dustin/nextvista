set :application, "nextvista"
set :repository,  "http://hg.west.spy.net/hg/web/#{application}/"
set :runner, 'www'

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/data/web/rails/#{application}"

set :scm, :mercurial

depend :remote, :command, "hg"
depend :remote, :gem, "SyslogLogger", ">= 1.4"
depend :remote, :gem, "memcache-client", ">= 1.5"
depend :remote, :gem, "postgres-pr", ">= 0.4.0"
depend :remote, :gem, "dustin-beanstalk-client", ">= 0.11.1"
depend :remote, :gem, "god", ">= 0.7"

role :app, "basket.west.spy.net"
role :web, "basket.west.spy.net"
role :db,  "basket.west.spy.net", :primary => true

desc "Starting and stopping via god."
deploy.task :start do
  sudo "god load #{deploy_to}/current/config/god.config"
  sudo "god start #{application}"
end

desc "Starting and stopping via god."
deploy.task :restart do
  sudo "god restart #{application}"
end

desc "Starting and stopping via god."
deploy.task :stop do
  sudo "god stop #{application}"
  sudo "god remove #{application}"
end

