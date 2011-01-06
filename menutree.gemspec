Gem::Specification.new do |s|
  s.name = %q{menutree}
  s.version = "0.1.2"

  s.authors = ["Mat Trudel", "Grant McInnes"]
  s.date = %q{2011-01-05}
  s.description = %q{Menutree is a framework for presenting a recursive REPL shell, inspired by the CLI found in Cisco IOS and similar products}
  s.email = %q{mat@geeky.net}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".gitignore",
     "README.md",
     "Rakefile",
     "lib/menutree.rb",
     "lib/menutree/tree.rb",
     "lib/menutree/leaf.rb",
     "lib/menutree/help.rb",
     "examples/example.rb",
     "examples/commands/leaf.rb",
     "examples/commands/submenu_one/leaf.rb",
     "examples/commands/submenu_two/leaf.rb",
     "menutree.gemspec"
  ]
  s.homepage = %q{http://github.com/mtrudel/menutree}
  s.require_paths = ["lib"]
  s.summary = %q{a simple hierachical REPL shell}
  s.add_dependency(%q<activesupport>, [">= 0"])
end

