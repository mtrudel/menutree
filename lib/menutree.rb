$:.unshift(File.join(File.dirname(__FILE__), 'menutree')) unless
  $:.include?(File.join(File.dirname(__FILE__), 'menutree')) || $:.include?(File.expand_path(File.join(File.dirname(__FILE__), 'menutree')))

require 'tree'

