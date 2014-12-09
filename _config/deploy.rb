require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

set :user, ENV['HOSTING_USER']
set :deploy_to, ENV['GARETH_HOSTING_DIR']
set :audio_source, ENV['GARETH_SYNC_HOME']
set :domain, 'garethgwynn.com'
set :repository, 'git@github.com:tomnatt/garethgwynn.git'
set :branch, 'master'

set :shared_paths, ['afan', 'demos', 'listenagainst', 'otherdemos']

task :setup do
  queue 'echo "-----> Create shared paths"'
  shared_dirs = shared_paths.map do |file|
    # this is a path if no extension
    # otherwise, we need to lose the filename
    path = "#{deploy_to}/#{shared_path}/#{file}"
    if File.extname(path).empty?
      path
    else
      File.dirname(path)
    end
  end.uniq

  shared_dirs.map do |dir|
    queue echo_cmd "mkdir -p #{dir}"
    queue echo_cmd "chmod g+rx,u+rwx #{dir}"
  end
end


desc "Deploys the current version to the server."
task :deploy do
  # sync the audio to the server
  # invoke :audio

  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    # build
    invoke :jekyll
    # cleanup
    invoke :'deploy:cleanup'
  end
end

desc "Syncs the audio with the server"
task :audio do
  path = "#{deploy_to}/#{shared_path}"

  system "rsync -az -e ssh #{audio_source}/afan/ #{user}@#{domain}:#{path}/afan/"
  system "rsync -az -e ssh #{audio_source}/demos/ #{user}@#{domain}:#{path}/demos/"
  system "rsync -az -e ssh #{audio_source}/listenagainst/ #{user}@#{domain}:#{path}/listenagainst/"
  system "rsync -az -e ssh #{audio_source}/otherdemos/ #{user}@#{domain}:#{path}/otherdemos/"
end

desc "Rebuild site"
task :jekyll do
  queue "cd #{deploy_to}/current"
  queue 'rake'
end
