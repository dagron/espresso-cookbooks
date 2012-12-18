class App < Thor::Group
  include Thor::Actions
  argument :app_name

  def self.source_root
    File.join(File.dirname(__FILE__))
  end

  def apply_directory_template
    self.destination_root = "output/#{app_name}"
    directory '_project_base', destination_root
    inside('sh') do
      run('chmod +x *')
    end
  end
end

class Database < Thor::Group
  include Thor::Actions

  def generate
    App.new(["database"]).invoke()
  end
end