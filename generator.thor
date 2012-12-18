EXAMPLES = {
  "recommended_folder_structure" => {},
  "code_reloading"               => {},
  "dev_env"                      => {},
  "db_initialization"            => {},
  "migrations"                   => {},
  "fast_tests"                   => {},
  "pagination"                   => {},
  "sprocket_assets"              => {},
  "forms"                        => {},
  "urls"                         => {},
  "sidekiq"                      => {},
  "dim"                          => {},
}

class Cookbooks < Thor
  include Thor::Actions

  def self.source_root
    File.join(File.dirname(__FILE__))
  end

  EXAMPLES.each do |k, v|
    desc k, "#{k} example"
    define_method k do
      apply_directory_template(k)
      send "#{k}_adjust_files" if respond_to?("#{k}_adjust_files")
    end
  end

  desc "generate_all", "(!!!) (re)create all examples"
  def generate_all
    FileUtils.rm_rf "generated"
    EXAMPLES.keys.each do |k|
      send(k)
    end
  end

  def code_reloading_adjust_files
    template('_templates/code_reloading/Readme.md', "Readme.md", :force => true)
  end

  def db_initialization_adjust_files
    template('_templates/db_initialization/Readme.md', "Readme.md", :force => true)
  end

  def pagination_adjust_files
    template('_templates/pagination/Readme.md', "Readme.md", :force => true)
    template("_templates/pagination/lib/ext/will_paginate.rb", "lib/ext/will_paginate.rb")

    append_to_file "config/environment.rb" do
      Util.unindent(%Q{

        ## will pagination
        require 'lib/ext/will_paginate'
      })
    end

    append_to_file 'Gemfile', :after => "gem 'class_loader'\n" do
      Util.unindent(%Q{
        ## will_paginate
        gem 'will_paginate'
      })
    end
    run 'bundle install'
  end

  def sidekiq_adjust_files
    template('_templates/sidekiq/Readme.md', "Readme.md", :force => true)
    template("_templates/sidekiq/sh/worker", "sh/worker")
    chmod "sh/worker", 0755
    template("_templates/sidekiq/app/workers/hard_worker.rb", "app/workers/hard_worker.rb")
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