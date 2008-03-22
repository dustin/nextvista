unless BEANSTALK_SERVERS.blank?
  AsyncObserver::Queue.queue = Beanstalk::Pool.new BEANSTALK_SERVERS
end

# This value should change every time you make a release of your app.
AsyncObserver::Queue.app_version = RELEASE_STAMP

# This tells async-observer how to run a job from an old version.
AsyncObserver::Worker.run_version = proc do |version, job|
  # Adjust this as necessary for your development or production environment.
  dir = File.dirname(RAILS_ROOT)
  AsyncObserver::Worker.run_job_in(dir, job)
end
