require 'rake'
require 'rake/testtask'
require 'rcov/rcovtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "menutree"
    s.summary = "a simple hierachical command line shell"
    s.description = "a simple hierachical command line shell"
    s.email = "mat@geeky.net"
    s.homepage = "http://github.com/mtrudel/menutree"
    s.authors = ["Mat Trude", "Grant McInnes"]
  end
  Jeweler::RubyforgeTasks.new do |rubyforge|
     rubyforge.doc_task = "yardoc"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new(:yardoc)
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yard, you must: sudo gem install yard"
  end
end


Rcov::RcovTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end


task :default => :rcov