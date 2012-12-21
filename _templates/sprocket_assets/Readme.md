## Sprocket Assets

Gemfile:

    gem 'alphasights-sinatra-sprockets', require: 'sinatra/sprockets' (a fork from sinatra-sprockets)




config.ru:

    map '/assets' do
      run Sinatra::Sprockets.environment
    end


environment.rb

    require 'sinatra/sprockets'



### now the env for sprockets...

    require 'sinatra/sprockets'
    require 'ostruct'

    ## create a fake sinatra app obj for sprockets
    fake_env                      = OpenStruct.new
    fake_env.settings             = OpenStruct.new
    fake_env.settings.public_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'public'))
    fake_env.root                 = File.expand_path(File.join(File.dirname(__FILE__), '..'))

    Sinatra::Sprockets.configure do |config|
      config.app = fake_env
      config.compress = false

      ['stylesheets', 'javascripts', 'images', 'vendor'].each do |dir|
        config.append_path(File.join('assets', dir))
      end
    end



##### Rakefile

    require 'sinatra/sprockets/rake'
    ## it gives you:
    # rake assets:clean       # Remove compiled assets
    # rake assets:precompile  # Compile all the assets named in config.assets.precompile


#### folder structure:

    assets
    - stylesheets
    - javascripts
      - vendor/jquery.js
      - verdor/bootstrap.js
      application.js
    - images
    - vendor


example for application.js in js folder:

      //= require vendor/jquery
      //= require vendor/bootstrap
      //= require_tree .



Now all requests agains /assets/... are handled by sprockets middleware. You may need to run `rake assets:precompile` the first time...

####  Start the server:

    $ sh/server

#### Now take a look at the results:
    $ curl localhost:9292/assets/application.css

    body {
      padding-top: 20px;
    }
    .logo {
    }



    .hello{
      color: green;
    }