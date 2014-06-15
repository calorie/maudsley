require 'thor'

class Cli < Thor
  desc 'new [PROJECT_NAME]', 'Create a new maudsley project.'
  def new(name = 'new_project')
    g = Generator.new(name)
    g.new_project
    g.message
  end

  desc 'example [PROJECT_NAME]', 'Create a example project.'
  def example(name = 'example_project')
    invoke :new, [name]

    example = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'example'))
    %w(src spec).each do |dir|
      Dir.glob(File.join(example, dir, '*')) do |f|
        FileUtils.cp f, File.join(name, dir)
      end
    end
  end
end
