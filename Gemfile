source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.3.1'

gem "daru", git: 'https://github.com/SciRuby/daru.git'
gem "font-awesome-rails"
gem "googlecharts"
gem 'bittrex'
gem 'popper_js'
gem 'bootstrap', '~> 4.0.0.alpha6'
#gem 'bootstrap-sass'
gem 'bootstrap-table-rails'
gem 'coffee-rails', '~> 4.2'
gem 'daru-data_tables', git: 'https://github.com/shekharrajak/daru-data_tables.git'
gem 'daru-view', git: 'https://github.com/shekharrajak/daru-view.git'
gem 'delayed_job_active_record'
gem 'faraday', '~> 0.9.0'
gem 'google_visualr', git: 'https://github.com/winston/google_visualr.git'
gem 'high_voltage'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'nyaplot', git: 'https://github.com/sciruby/nyaplot.git'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'uglifier', '>= 1.3.0'
gem 'twitter'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development do
  gem 'better_errors'
  gem 'rails_layout'
end
