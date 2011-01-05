module MenuTree
  INDENT = "\t"
  COMMAND_WIDTH = -12
  BUILTINS = {
    "help" => "Displays this message",
    "quit" => "Quits this session",
    ".." => "Goes up a level in the menu (or quits if at the root)",
  }

  module Help
    def display_help
      display_help_section("Built-in commands", BUILTINS)
      display_help_section("Leaf commands", @leaf.commands)
      display_help_section("Submenus", submenus)
    end

    def display_help_section(section, contents, indent = 0)
      puts INDENT*indent + section
      contents.each do |command, description|
        puts INDENT*(indent+1) + sprintf("%#{COMMAND_WIDTH}s %s", command, description)
      end
      puts ""
    end
  end
end

