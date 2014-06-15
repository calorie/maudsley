require 'maudsley/accessor'
require 'maudsley/configurator'
require 'maudsley/runner'
include Accessor

@config = Configurator.new(project_root).load_config

Dir.glob(File.join(maudsley_root, 'tasks', '*.rake')) do |task|
  load task
end
