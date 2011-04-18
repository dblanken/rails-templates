# Get project name from path
app_name = `pwd`.split('/').last.strip.downcase.gsub(/\s|-/, '_')

# Create README.markdown
run 'rm README'
file 'README.markdown', "# #{app_name.capitalize}"

# create rvmrc file
create_file ".rvmrc", "rvm gemset use #{app_name}"

gem "simple_form"
gem "jquery-rails"
gem "nifty-generators"

run 'bundle install'

rake "db:create", :env => 'development'
rake "db:create", :env => 'test'

generate 'simple_form:install'
generate 'nifty:layout'

remove_file 'public/javascripts/rails.js' # jquery-rails replaces this
generate 'jquery:install --ui'

# clean up rails defaults
remove_file 'public/index.html'
remove_file 'public/images/rails.png'
run 'cp config/database.yml config/database.example.yml'
run "echo 'config/database.yml' >> .gitignore"

# commit to git
git :init
git :add => "."
git :commit => "-a -m 'create initial application'"

say <<-eos
  ============================================================================
  Your new Rails application is ready to go.
  
  Don't forget to scroll up for important messages from installed generators.
eos