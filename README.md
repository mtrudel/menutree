# Menutree

Menutree is a framework for presenting a recursive Read-Eval-Print Loop (REPL) shell on the command 
line, inspired by the CLI found in Cisco IOS and other similar products. 
Menutree lets users issue commands via an interactive nested shell interface, 
and also directly from the command line. 

The menu structure and commands therein are defined by a directory of ruby 
scripts conforming to a simple interface. Inline help, command completion, and
readline support are all built in. 

## Example:

<pre>
$ ./examples/example.rb
> action_one a b c 
This is action one, called with: a b c
> submenu_one
submenu_one> action_one
This is action one in submenu one, called with: 
submenu_one> ..
> submenu_two
submenu_two> action_one
This is action one in submenu two, called with: 
submenu_two> quit
</pre>

Commands could also be run from the shell:

<pre>
$ ./examples/example.rb submenu_one action_two a b c
This is action two in submenu one, called with: a b c
</pre>

To implement this, one would provide Menutree with a directory that looked
like:

<pre>
commands/
  leaf.rb
  submenu_one/
    leaf.rb
  submenu_two/
    leaf.rb
</pre>

Commands are defined inside a leaf.rb file in each directory, which adheres to
a minimal DSL like so:

<pre>
leaf do |tree|
  desc "This is action one's help"
  def action_one(*args)
    puts "This is action one, called with: #{args.join ' '}"
  end

  desc "This is action two's help"
  def action_two(*args)
    puts "This is action two, called with: #{args.join ' '}"
  end
end
</pre>
