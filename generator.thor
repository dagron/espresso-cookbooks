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

  desc "apply_directory_template", "moves base app to a path"
  def apply_directory_template(app_name)
    self.destination_root = "generated/#{app_name}"
    directory '_project_base', destination_root
    inside('sh') do
      run('chmod +x *')
    end
  end
end