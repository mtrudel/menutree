# Menutree

Menutree is a framework for presenting a recursive menu shell on the command 
line, inspired by the CLI found in Cisco IOS and other similar products. 
Menutree lets users issue commands via an interactive nested shell interface, 
and also directly from the command line. 

The menu structure and commands therein are defined by a directory of ruby 
scripts conforming to a simple interface. Inline help, command completion, and
readline support are all built in. 

## Example:

Given a hypothetical program 'ticker' that uses the Menutree gem to manage a list of 
tickets, a sample interaction might look like:

<pre>
$ ticker
> init
Ticker created an empty ticket database
> add "Do a little dance"
Ticket "Do a little dance" added as ticket 213
> rm
rm> 213
Ticket 213 ("Do a little dance") removed
rm> ..
> exit
</pre>

Commands could also be run from the shell:

<pre>
$ ticker add "Make a little love"
Ticket "Make a little love" added as ticket 214
</pre>

To implement this, ticker would provide Menutree with a directory that looked
like:

<pre>
commands/
	init.rb
	add/
		default.rb
	rm/
		default.rb
</pre>

