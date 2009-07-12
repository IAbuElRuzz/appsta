gem "appsta"
require "appsta"
self.class.instance_eval { include Appsta }

# Remove certain files
["README", "public/index.html", "public/favicon.ico", "public/javascripts/*"].each do |path|
  run "rm -f #{path}"
end

# Grab jQuery for use in the app
run "curl -s -L http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js > public/javascripts/jquery.js"

# Setup the Git repo
git :init
git :add => "."
git :commit => "-a -m 'initial commit by Appsta'"

# Setup the app on Heroku
[:production, :staging].each { |env| heroku(env) }

# Setup the project repo on GitHub
github

# Push the app to production, staging, and GitHub
[:origin, :production, :staging].each { |remote| git :push => "#{remote} master" }
