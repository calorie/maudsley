require 'yaml'

class Configurator
  def initialize(project_root_path)
    @project_root = project_root_path
  end

  def load_config
    path = File.join(@project_root, 'project.yml')
    validate(path)
    YAML.load(File.read(path))
  end

  private

  def validate(path)
    unless File.exist?(path)
      raise "Found no Maudsley project file (#{path})"
    end
  end
end
