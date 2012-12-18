##  Sidekiq

For background jobs I would recommend Sidekiq, it's an amazing library.

It requires:
- ruby1.9 or jruby/rubinius
- redis-server running


To test the worker:
    $ sh/worker

Generate some jobs:
    $ sh/c
    $ irb> 100.times do HardWorker.perform_async('bob', 5) end

Watch the workers doing the work!