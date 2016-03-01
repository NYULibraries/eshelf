set :rails_env, "qa"
set(:branch, ENV["GIT_BRANCH"].gsub(/remotes\//,"").gsub(/origin\//,""))
set(:puma_ssl_enabled, true)
