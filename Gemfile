source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.6'
gem 'capistrano', '~> 3.7', '>= 3.7.1'
gem 'capistrano-rails', '~> 1.2'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rbenv', '~> 2.1'

###########################################################################
gem 'chart-js-rails'
gem "chartkick"
gem 'devise'
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'
gem 'cancancan', '~> 2.0'
gem 'faker'
gem 'will_paginate'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'rails-jquery-autocomplete'
gem 'rails-assets-sweetalert2', '~> 5.1.1', source: 'https://rails-assets.org'
gem 'jquery-ui-rails'
gem 'greensock-rails'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails', '4.3.1'
gem 'jquery-datatables-rails', '~> 3.4.0'
gem 'jbuilder', '~> 2.5'
gem 'bootstrap-sass', '3.3.7'
#gem para o calendário
gem 'momentjs-rails' , '2.20.1' 
gem 'bootstrap3-datetimepicker-rails', '~> 4.14.30'
gem 'bootstrap-datepicker-rails'

gem 'rubyzip', '>= 1.2.1'
gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844'
gem 'axlsx_rails'
group :development, :test do
  gem 'sqlite3', '1.3.13'
  
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'pry-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg', '1.1.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'validates_cpf_cnpj'
