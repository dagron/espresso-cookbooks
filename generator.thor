EXAMPLES = {
  "auth_warden"                  => {},
  "code_reloading"               => {},
  "migrations"                   => {},
  "pagination"                   => {},
  "sprocket_assets"              => {},
  "sidekiq"                      => {},
}

class Cookbooks < Thor
  include Thor::Actions

  def self.source_root
    File.join(File.dirname(__FILE__))
  end

  desc "generate_all", "(re)create all examples"
  def generate_all
    FileUtils.rm_rf "generated"
    EXAMPLES.keys.each do |k|
      send(k)
    end
  end


protected
  no_tasks do
    EXAMPLES.keys.sort.each do |k|
      desc k, "#{k} example"
      define_method k do
        apply_directory_template(k)
        send("#{k}_adjust_files", k) if respond_to?("#{k}_adjust_files")
      end
    end
  end

  def copy_stuff(example, files)
    files = [files] unless files.is_a?(Array)
    files.each do |file|
      copy_file("_templates/#{example}/#{file}", file, :force => true)
    end
  end

  def auth_warden_adjust_files(example)
    pagination_adjust_files('pagination')
    files = [
      "Readme.md",
      "lib/warden.rb"
    ]
    copy_stuff(example, files)
    append_to_file 'Gemfile', :after => "gem 'class_loader'\n" do
      Util.unindent(%Q{
        ## warden auth
        gem 'warden'
      })
    end
  end

  def code_reloading_adjust_files(example)
    copy_stuff(example, "Readme.md")
  end

  def db_initialization_adjust_files(example)
    copy_stuff(example, "Readme.md")
  end

  def pagination_adjust_files(example)
    files = [
      "Readme.md",
      "lib/ext/will_paginate.rb",
      "config/environment.rb",
      "app/models/user.rb",
      "app/controllers/my_app/frontend/pagination.rb",
      "view/pagination/index.erb"
    ]
    copy_stuff(example, files)

    append_to_file 'Gemfile', :after => "gem 'class_loader'\n" do
      Util.unindent(%Q{
        ## will_paginate
        gem 'will_paginate'
        # active-record, simplified
        gem 'mini_record'
        gem 'sqlite3'
      })
    end

    empty_directory "db"
    run 'bundle install'
  end

  def sprocket_assets_adjust_files(example)
    files =[
      "Readme.md",
      "Rakefile",
      "assets/stylesheets/vendor/bootstrap.css",
      "assets/stylesheets/application.css"
    ]
    copy_stuff example, files

    insert_into_file "config.ru", :after => "require './app'" do
      Util.unindent(%Q{

        ## assets via sinatra-sprockets
        map '/assets' do
          run Sinatra::Sprockets.environment
        end
      })
    end

    append_to_file 'Gemfile', :after => "gem 'class_loader'\n" do
      Util.unindent(%Q{

        ## middleware for sprockets
        gem 'alphasights-sinatra-sprockets', require: 'sinatra/sprockets'
      })
    end

    insert_into_file "config/environment.rb", :after => "ClassLoader.preload 'app/controllers'\n" do
      Util.unindent(%Q{
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
      })
    end

    %w(stylesheets javascripts images vendor).each do |f|
      empty_directory "assets/#{f}"
    end
    run 'bundle install'
  end

  def sidekiq_adjust_files(example)
    files =[
      "Readme.md",
      "sh/worker",
      "app/workers/hard_worker.rb",
    ]
    copy_stuff example, files
    chmod "sh/worker", 0755

    append_to_file 'Gemfile', :after => "gem 'class_loader'\n" do
      Util.unindent(%Q{

        ## A background worker
        gem 'sidekiq'
        # Sinatra for the sidekiq UI
        gem 'sinatra'
        gem 'slim'
      })
    end
    gsub_file 'config/environment.rb', /\(app\/lib app\/models app\/controllers\)/, "(app/lib app/models app/controllers app/workers)"
    insert_into_file "config.ru", :after => "require './app'" do
      Util.unindent(%Q{

        ## mount the sinatra UI
        require 'sidekiq/web'
        map "/sidekiq" do
          run Sidekiq::Web
        end
      })
    end
    run 'bundle install'
  end

  desc "apply_directory_template", "moves base app to a path"
  def apply_directory_template(app_name)
    self.destination_root = "generated/#{app_name}"
    directory '_project_base', destination_root
    inside('sh') do
      run('chmod +x *')
    end
  end
end

class Util
  def self.unindent(source)
    lines       = source.split("\n")
    min_spaces  = lines.map{|x| (x.index(/\S/)||9999)}.min
    short_lines = lines.map{|l| l[min_spaces..l.length]}
    short_lines.join("\n") + "\n"
  end
end