load_template "http://github.com/dblanken/rails-templates/raw/master/base.rb"

plugin 'rubycas-client-iupui', :git => 'ssh://deploy@cry/var/git/rubycas-client-iupui.git'
generate :iupui_cas
rake "db:migrate"

git :add => "."
git :commit => "-m 'adding authentication/authorization'"
