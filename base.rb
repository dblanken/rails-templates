if yes?("Do you want to use RSpec for testing?")
  plugin "rspec", :version => '1.2.9', :git => "git://github.com/dchelimsky/rspec.git"
  plugin "rspec-rails", :version => '1.2.9', :git => "git://github.com/dchelimsky/rspec-rails.git"
  generate :rspec
end

if yes?("Do you want to searchify?")
  plugin "searchify", :git => "git://github.com/dblanken/searchify.git"
end

plugin "nifty-generators", :git => "git://github.com/dblanken/nifty-generators.git"
generate :nifty_layout

git :init

run "echo 'TODO add readme content' > README"
run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"

file ".gitignore", <<-END
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
END

git :add => "."
git :commit => "-m 'initial commit'"
