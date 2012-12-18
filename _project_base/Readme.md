
# Recommended folder stucture for any web project without strict conventions


This is more like a soft guideline for you to have a place, where you put your stuff.


    config.ru + app.rb: mounts you Rack app

    app/:
        place for business logic (a ka your app)


    config/:
        configuration should happen here

    config/environment.rb
        prepares everything

    Readme.md
        [[http://tom.preston-werner.com/2010/08/23/readme-driven-development.html]]


    sh/: folder for your convenience scripts, when kept consistent in all your projects, very helpful

    sh/c:
        console

    sh/server:
        starts the web server

    sh/test:
        runs the tests

## application MyApp
     - frontend module (MyApp::Frontend)
        - Home
     - backend module  (MyApp::Backend)
        - Home
        - BigBackendController

We mount those modules in config.ru to

    '/'        => frontend
    '/backend' => backend
