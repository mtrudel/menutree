Gem::Specification.new do |s|
  s.name = %q{menutree}
  s.version = "0.1.0"

  s.authors = ["Mat Trudel", "Grant McInnes"]
  s.date = %q{2011-01-04}
  s.description = %q{Menutree is a framework for presenting a recursive REPL shell, inspired by the CLI found in Cisco IOS and similar products}
  s.email = %q{mat@geeky.net}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".gitignore",
     "README.md",
     "Rakefile",
     "lib/base.rb",
     "lib/menutree.rb",
     "examples/ticket/menu.rb",
     "examples/ticket/ticket.rb",
     "examples/ticket/submenu_one/",
     "examples/ticket/submenu_two/",
     "menutree.gemspec"
  ]
  s.homepage = %q{http://github.com/mtrudel/menutree}
  s.require_paths = ["lib"]
  s.summary = %q{a simple hierachical REPL shell}
  s.add_dependency(%q<activesupport>, [">= 0"])
end

