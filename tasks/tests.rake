namespace :spec do
  desc 'Run all tests.'
  task :all do
    root = project_root
    config  = @config[:mpispec]
    cmd = "mpispec -np #{config[:processes]} #{config[:options]}"
    if Runner.new(root).generate && find_executable('mpispec')
      Dir.chdir(root) { system(cmd) }
    end
  end
end
