##  Sidekiq

For background jobs I would recommend Sidekiq, it's an amazing library.

It requires:

      - ruby1.9 or jruby/rubinius
      - redis-server running

Put your worker files into

    app/workers/...

Adjust the $LOAD_PATH:

    %w(app/lib app/models app/controllers app/workers)

Adjust Gemfile:

    gem 'sidekiq'
    # for UI
    gem 'sinatra'
    gem 'slim'

Mount the Web-UI in config.ru:

    require 'sidekiq/web'
    map "/sidekiq" do
      run Sidekiq::Web
    end


To test the worker:

    $ sh/worker

Generate some jobs:

    $ sh/c
    $ irb> 100.times do HardWorker.perform_async('bob', 5) end

Watch the workers doing the work!

The Web UI is available on:

    0.0.0.0:9292/sidekiq