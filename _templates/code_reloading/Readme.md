## Code Reloading

Since Rails uses (rather) advanced code-reloading techniques, that make some assumptions about
your folder-structure, it's not trivial to construct a proper code-reloading for every app.
We suggest to use tools, that restart the app, whenever code changes. My favourite tool is
"rerun", that takes a file/folder list as option to watch and re-executes your command, when something
changes.


A simple example:

      rerun --pattern '{Gemfile,Gemfile.lock,config.ru,*.rb,config/*,lib/**/*.rb,app/**/**/*.rb}' -- rackup


Put this into an executable script and you're done, e.g

      $ sh/server