require 'fileutils'

class Generator
  def initialize(name)
    @project_name = name
  end

  def new_project
    maudsley = File.join(@project_name, 'vendor', 'maudsley')
    src      = File.join(@project_name, 'src')
    spec     = File.join(@project_name, 'spec')
    support  = File.join(@project_name, 'spec', 'support')
    build    = File.join(@project_name, 'build')

    mkdir(maudsley, src, spec, support, build)
    vendor(maudsley, 'lib', 'tasks', 'template')
    assets('Rakefile', 'project.yml')

    @message = <<-MSG
Project '#{@project_name}' created!
Execute 'rake -T' to view available test & build tasks.
    MSG
  end

  def message
    puts @message unless @message.to_s.empty?
  end

  private

  def maudsley_root
    File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
  end

  def mkdir(*dirs)
    dirs.each { |d| FileUtils.mkdir_p(d) }
  end

  def vendor(path, *src)
    root = maudsley_root
    src.each do |s|
      FileUtils.cp_r(File.join(root, s), File.join(path, s))
    end
  end

  def assets(*files)
    root = maudsley_root
    files.each do |f|
      FileUtils.cp(File.join(root, 'assets', f), File.join(@project_name, f))
    end
  end
end
