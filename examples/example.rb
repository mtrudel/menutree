#!/usr/bin/env ruby

require 'rubygems'
require 'menutree'

MenuTree::Tree.new(File.join(File.dirname(__FILE__), 'commands')).repl(ARGV)
