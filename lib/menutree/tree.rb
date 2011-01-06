require 'readline'
require 'active_support'
require 'leaf'
require 'help'

module MenuTree
  class Tree
    include Help
    attr_accessor :directory
    attr_accessor :prompt  
    attr_accessor :leaf
    
    def initialize(directory, parent = "")
      @directory = directory
      if parent.is_a? String
        @prompt = parent
      elsif !parent.prompt.empty?
        @prompt = parent.prompt + "/" + File.basename(@directory)
      else
        @prompt = File.basename(@directory)
      end

      file = File.join(@directory, "leaf.rb")
      @leaf = MenuTree::Leaf.new(self)
      @leaf.instance_eval(File.read(file), file) if File.exists? file
    end

    def repl(cmds)
      one_shot = true unless cmds.empty?
      to_run = cmds.shift    
      while true do
        Readline.completion_append_character = " "
        Readline.completion_proc = Proc.new do |str|
          commands(str)
        end
        if (to_run.nil?) 
          cmds = Readline.readline("#{@prompt}> ", true).split
          to_run = cmds.shift
        end
          
        # If it's a builtin, run it
        if (to_run.nil?) 
          next
        elsif (to_run == "help" or to_run == "?")
          display_help
        elsif (to_run == "quit")
          exit
        elsif (to_run == "..")
          return      
        elsif File.directory?(File.join(@directory, to_run))
          menu = MenuTree::Tree.new(File.join(@directory, to_run), self)
          menu.repl(cmds)
        elsif leaf_commands.include? to_run
          @leaf.send to_run, cmds
        else
          puts "Unknown command #{to_run}"
        end
        to_run = nil
        return if one_shot
      end
    end
    
    def commands(prefix='')
      (leaf_commands + submenus).select { |command| command =~ /^#{Regexp.escape(prefix)}/ }
    end

    def leaf_commands
      @leaf.commands.keys.map { |x| x.to_s }
    end

    def submenus
      Dir.new(@directory).select { |entry| entry =~ /^[^\.]/ and File.directory?(File.join(@directory, entry)) }
    end
  end
end
