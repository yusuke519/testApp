source 'https://rubygems.org'
ruby '2.0.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
group :production do
  gem 'pg'
end
group :development, :test do
  gem 'sqlite3'
end
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# twitter bootstrap css & javascript toolkit
gem 'twitter-bootswatch-rails', '~> 3.0.0'

# twitter bootstrap helpers gem, e.g., alerts etc...
gem 'twitter-bootswatch-rails-helpers'

#heroku
gem 'rails_12factor', group: :production
#Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Debugging tools
group :development, :staging do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'mail_view'
  gem 'pry-rails'
  gem 'pry-debugger'
  gem 'pry-remote'
  gem 'quiet_assets'
  gem 'sextant'
end

# active recordを使う
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'
# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
#
#

# Gon:Rails（Controller上）のデータとJSでデータを共有する
gem 'gon'

# Chart.js for Rails
gem 'chart-js-rails'
