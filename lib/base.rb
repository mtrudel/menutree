require 'readline'
require 'active_support'
require 'menu'

module MenuTree
  class Base
    attr_accessor :directory
    attr_accessor :parent
    attr_accessor :prompt  
    attr_accessor :instance
    
    def initialize(directory, parent = "")
      @directory = directory
      @parent = parent
      if @parent.is_a? self.class
        @prompt = @parent.prompt + "/" + File.basename(@directory)
      else
        @prompt = @parent
      end
      file = File.join(@directory, "menu.rb")
      @instance = MenuTree::Menu.new(self)
      @instance.instance_eval(File.read(file), file) if File.exists? file
    end

    def repl(cmds)
      Readline.completion_append_character = " "
      Readline.completion_proc = Proc.new do |str|
        commands(str)
      end

      one_shot = true unless cmds.empty?
      to_run = cmds.shift    
      while true do
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
          menu = MenuTree::Base.new(File.join(@directory, to_run), self)
          menu.repl(cmds)
        else 
          @instance.send to_run, cmds rescue puts "Unknown command #{to_run}"
        end
        to_run = nil
        return if one_shot
      end
    end
    
    def commands(prefix='')
      (instance_commands + submenus).select { |command| command =~ /^#{Regexp.escape(prefix)}/ }
    end

    def instance_commands
      @instance.methods - MenuTree::Menu.instance_methods
    end

    def submenus
      Dir.new(@directory).select { |entry| entry =~ /^[^\.]/ and File.directory?(entry) }
    end

    def display_help
      # TODO
      puts <<EOF
  Builtin commands:
    help:\t\t\t\tDisplays this message
    quit:\t\t\t\tQuits this session
    ..:  \t\t\t\tGoes up a level in the menu (or quits if at the root)
    
  #{@prompt} commands:
EOF
      instance_commands.each do |cmd| 
        puts "#{cmd}"
      end

      puts "Submenus:"
      submenus.each do |submenu|
        puts "#{submenu}"
      end
    end
  end
end
