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

class App < Thor::Group
  include Thor::Actions
  argument :app_name

  def self.source_root
    File.join(File.dirname(__FILE__))
  end

  def apply_directory_template
    self.destination_root = "generated/#{app_name}"
    directory '_project_base', destination_root
    inside('sh') do
      run('chmod +x *')
    end
  end
end

class Example < Thor
  include Thor::Actions

  EXAMPLES.each do |k, v|
      desc k, "#{k} example"
      define_method k do
        App.new(["#{k}"]).invoke_all
      end
    end
end