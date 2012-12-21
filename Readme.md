**Some recipies and smaller snippets for [Espresso](http://e.github.com) **

## Big Picture
  - [Recommended Folder Structure][recommended_folder_structure]
  - [Code Reloading][code_reloading]
  - [dev/test environment][dev_env]
  -
## Database
  - [DB Initialization][db_initialization]
  - [Migrations][migrations]

## Testing
  - [fast tests][fast_tests]

## Views
  - [View Helpers][view_helpers]
  - [Pagination][pagination]
  - [Assets][sprocket_assets]
  - [Forms][forms]
  - [URL Generation][urls]

## Misc
  - [Background Jobs with Sidekiq][sidekiq]
  - [Dependency Injection with DIM][dim]


[recommended_folder_structure]: espresso-cookbooks/tree/master/_templates/recommended_folder_structure/Readme.md
[code_reloading]:               espresso-cookbooks/tree/master/_templates/code_reloading/Readme.md
[dev_env]:                      espresso-cookbooks/tree/master/_templates/dev_env/Readme.md
[db_initialization]:            espresso-cookbooks/tree/master/_templates/db_initialization/Readme.md
[migrations]:                   espresso-cookbooks/tree/master/_templates/migrations/Readme.md
[fast_tests]:                   espresso-cookbooks/tree/master/_templates/fast_tests/Readme.md
[view_helpers]:                 espresso-cookbooks/tree/master/_templates/view_helpers/Readme.md
[pagination]:                   espresso-cookbooks/tree/master/_templates/pagination/Readme.md
[sprocket_assets]:              espresso-cookbooks/tree/master/_templates/sprocket_assets/Readme.md
[forms]:                        espresso-cookbooks/tree/master/_templates/forms/Readme.md
[urls]:                         espresso-cookbooks/tree/master/_templates/urls/Readme.md
[sidekiq]:                      espresso-cookbooks/tree/master/_templates/sidekiq/Readme.md
[dim]:                          espresso-cookbooks/tree/master/_templates/dim/Readme.md



## Development:
This project uses Thor, it regenerates all examples from a base project and makes some adjustments to each one.

to generate examples run:
    $ thor cookbooks:generate_all

all examples will be in the "generated"-directory

