class App < Thor::Group
  include Thor::Actions
  argument :app_name

  def self.source_root
    File.join(File.dirname(__FILE__), '_project_base')
  end

  def apply_directory_template
    directory 'template', app_name
  end
end