set :application, "nextvista"
set :repository,  "http://hg.west.spy.net/hg/web/nextvista/"
set :runner, 'www'

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/data/web/rails/#{application}"

set :scm, :mercurial

role :app, "basket.west.spy.net"
role :web, "basket.west.spy.net"
role :db,  "basket.west.spy.net", :primary => true

NAME = "nextvista"

desc "Starting and stopping via god."
deploy.task :start do
  sudo "god load #{deploy_to}/current/config/god.config"
  sudo "god start #{NAME}"
end
desc "Starting and stopping via god."
deploy.task :restart do
  sudo "god restart #{NAME}"
end
desc "Starting and stopping via god."
deploy.task :stop do
  sudo "god stop #{NAME}"
  sudo "god remove #{NAME}"
end

