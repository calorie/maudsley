module Accessor
  module_function

  def project_root
    if ENV['MAUDSLEY_PROJECT_ROOT']
      ENV['MAUDSLEY_PROJECT_ROOT']
    else
      raise 'Environment variable `MAUDSLEY_PROJECT_ROOT` is not found.'
    end
  end

  def maudsley_root
    File.join(project_root, 'vendor', 'maudsley')
  end
end
