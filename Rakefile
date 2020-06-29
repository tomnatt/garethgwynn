require 'jekyll'

task default: [:clean] do
  # assemble the site compenents
  # system "rsync -r $GARETH_SYNC_HOME/afan ."
  # system "rsync -r --exclude 'index.php' $GARETH_SYNC_HOME/demos ."
  # system "rsync -r $GARETH_SYNC_HOME/listenagainst ."
  # system "rsync -r $GARETH_SYNC_HOME/otherdemos ."

  # build the site
  Jekyll::Commands::Build.process({ config: '_config/jekyll_config.yml' })
end

task :serve do
  # Jekyll::Commands::Serve.process({ config: '_config/jekyll_config.yml' })
  system 'bundle exec jekyll serve --config _config/jekyll_config.yml --incremental'
end

task :clean do
  Jekyll::Commands::Clean.process({ config: '_config/jekyll_config.yml' })
end
