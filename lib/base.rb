require 'readline'
require 'active_support'

class MenuTree
  attr_accessor :directory
  attr_accessor :parent
  attr_accessor :prompt  
  
  def initialize(directory, parent = "")
    @directory = directory
    @parent = parent
    if @parent.is_a? self.class
      @prompt = @parent.prompt + "/" + File.basename(@directory)
    else
      @prompt = @parent
    end
  end
  
  def run_command(cmds)
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
      elsif File.exists?(File.join(@directory, "#{to_run}.rb"))
        # If we have a .rb file, run it with the rest of cmd as arguments
        # TODO -- use .extend?
        require File.join(@directory, "#{to_run}")
        eval(to_run.camelize).new.run(cmds)
      elsif File.directory?(File.join(@directory, to_run))
        menu = MenuTree.new(File.join(@directory, to_run), self)
        menu.run_command(cmds)
      elsif File.exists?(File.join(@directory, "default.rb"))
        # TODO let default handle it, allowing us to have proxy menus
      else 
        puts "Unknown command #{to_run}"
      end
      to_run = nil
      return if one_shot
    end
  end
  
  def commands(prefix='')
    completions = []
    Dir.new(@directory).each do |command|
      if command =~ /^[^\.]/ and command =~ /^#{Regexp.escape(prefix)}/ and File.file?(File.join(@directory, command))
        completions << File.basename(command, '.rb') 
      end
    end
    completions
  end

  def display_help
    puts <<EOF
Builtin commands:
  help:\t\t\t\tDisplays this message
  quit:\t\t\t\tQuits this session
  ..:  \t\t\t\tGoes up a level in the menu (or quits if at the root)
  
#{@parent} commands:
EOF
    
    # TODO display some help for each submenu
    commands.each do |cmd| 
      require File.join(@directory, "#{cmd}")
      puts "  #{cmd}:\t\t\t\t#{eval(cmd.camelize).new.description}"
    end
  end
end
