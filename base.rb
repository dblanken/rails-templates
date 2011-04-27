# Get project name from path
app_name = `pwd`.split('/').last.strip.downcase.gsub(/\s|-/, '_')

# Create README.markdown
run 'rm README'
file 'README.markdown', "# #{app_name.capitalize}"

# create rvmrc file
create_file ".rvmrc", "rvm use 1.8.7@#{app_name} --create"

gem "simple_form"
gem "jquery-rails"
gem "nifty-generators", :git => "git@github.com:dblanken/nifty-generators.git"
gem "mocha", :require => false

run "rvm use 1.8.7@#{app_name} --create"
run 'bundle install'

rake "db:create", :env => 'development'
rake "db:create", :env => 'test'

remove_file 'app/views/layouts/application.html.erb'
generate 'nifty:layout'
generate 'simple_form:install'

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