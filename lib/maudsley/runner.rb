require 'erb'

class Runner
  def initialize(project_root_path)
    @project_root = project_root_path
  end

  def generate
    src_path  = File.join(@project_root, 'src')
    spec_path = File.join(@project_root, 'spec')
    headers   = header_filenames(src_path)
    specs     = spec_filenames(spec_path)
    return false if headers.empty? || specs.empty?
    template  = File.join(@project_root, 'vendor', 'maudsley', 'template', 'main_spec.c.erb')
    erb       = ERB.new(IO.read(template), nil, '%')
    File.write(File.join(spec_path, 'main_spec.c'), erb.result(binding))
  end

  private

  def header_filenames(path)
    headers = []
    Dir.glob(File.join(path, '*.h')) do |header|
      headers << File.basename(header)
    end
    headers
  end

  def spec_filenames(path)
    specs = []
    Dir.glob(File.join(path, '*_spec.c')) do |spec|
      specs << File.basename(spec, '.c') unless /main_spec\.c$/ =~ spec
    end
    specs
  end
end
