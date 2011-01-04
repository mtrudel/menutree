require 'rubygems'
require 'menutree'

MenuTree::Base.new(File.dirname(__FILE__)).repl(ARGV)
