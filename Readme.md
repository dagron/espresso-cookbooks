#### Some recipies and smaller snippets for [Espresso](http://espresso.github.com)

## Big Picture
  - [Recommended Folder Structure][recommended_folder_structure]
  - [Code Reloading][code_reloading]
  - [dev/test environment][dev_env] (TODO)

## Database
  - [DB Initialization][db_initialization] (TODO)
  - [Migrations][migrations] (TODO)

## Testing
  - [fast tests][fast_tests] (TODO)

## Views
  - [Pagination][pagination]
  - [Assets with Sprockets][sprocket_assets]
  - [URL Generation][urls] (TODO)
  - [View Helpers][view_helpers] (TODO)
  - [Forms][forms] (TODO)

## Misc
  - [Background Jobs with Sidekiq][sidekiq]
  - [Dependency Injection with DIM][dim] (TODO)


[recommended_folder_structure]: espresso-cookbooks/tree/master/_project_base/
[code_reloading]:               espresso-cookbooks/tree/master/_templates/code_reloading/
[dev_env]:                      espresso-cookbooks/tree/master/_templates/dev_env/
[db_initialization]:            espresso-cookbooks/tree/master/_templates/db_initialization/
[migrations]:                   espresso-cookbooks/tree/master/_templates/migrations/
[fast_tests]:                   espresso-cookbooks/tree/master/_templates/fast_tests/
[view_helpers]:                 espresso-cookbooks/tree/master/_templates/view_helpers/
[pagination]:                   espresso-cookbooks/tree/master/_templates/pagination/
[sprocket_assets]:              espresso-cookbooks/tree/master/_templates/sprocket_assets/
[forms]:                        espresso-cookbooks/tree/master/_templates/forms/
[urls]:                         espresso-cookbooks/tree/master/_templates/urls/
[sidekiq]:                      espresso-cookbooks/tree/master/_templates/sidekiq/
[dim]:                          espresso-cookbooks/tree/master/_templates/dim/
[generator]:                    espresso-cookbooks/blob/master/generator.thor



## Development:
This project uses Thor, it regenerates all examples from a base project and makes some adjustments to each one.

to generate examples run:

    $ thor cookbooks:generate_all

all examples will be in the "generated"-directory


Take a look at the [Thor File][generator] for further inspiration.