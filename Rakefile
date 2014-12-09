task :default do
  # assemble the site compenents
  # system "rsync -r $GARETH_SYNC_HOME/afan ."
  # system "rsync -r --exclude 'index.php' $GARETH_SYNC_HOME/demos ."
  # system "rsync -r $GARETH_SYNC_HOME/listenagainst ."
  # system "rsync -r $GARETH_SYNC_HOME/otherdemos ."

  # compile the css
  system "bundle exec compass compile --config _config/compass_config.rb "

  # build the site
  system "bundle exec jekyll build --config _config/jekyll_config.yml"
end