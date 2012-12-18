class App < Thor::Group
  include Thor::Actions
  argument :app_name

  def self.source_root
    File.join(File.dirname(__FILE__))
  end

  def apply_directory_template
    directory '_project_base', "test/#{app_name}"
  end
end