source :rubygems

gem 'rails',                '~> 3.1.2'
gem 'rake',                 '~> 0.9.2.2'

gem 'travis-core', :git => 'git://github.com/travis-ci/travis-core.git', :require => 'travis_core/engine', :ref => 'fac2807cd9d3f9cc90d1af4f2c0e92de4f96e357'
gem 'amqp',                 '~> 0.8.3'
#
# TODO remove this once pusher > 0.8.4 has been released. should be in travis-core's gemspec
gem 'pusher', :git => 'https://github.com/juno/pusher-gem.git', :ref => 'd025ccb'

# app
gem 'refraction',           '~> 0.2.0'
gem 'devise',               '~> 1.5.0'
gem 'omniauth-github',      '~> 1.0.0'
gem 'unobtrusive_flash',    '~> 0.0.2'

# structures
gem 'json',                 '~> 1.5.4'
gem 'yajl-ruby',            '~> 1.1.0'
gem 'rabl',                 '~> 0.5.1'

# db
gem 'pg',                   '~> 0.11.0'
gem 'silent-postgres',      '~> 0.0.8'

# apis
gem 'hoptoad_notifier',     '~> 2.4.11'
gem 'newrelic_rpm',         '~> 3.3.0'

# heroku
gem 'unicorn',              '~> 4.1.1'

# assets
group :assets do
  gem 'sass-rails',         '~> 3.1.5'
  gem 'coffee-rails',       '~> 3.1.1'
  gem 'uglifier',           '~> 1.1.0'
  gem 'compass',            '0.12.alpha.0'
end

group :development, :test, :jasmine do
  gem 'rails-dev-tweaks',   '~> 0.5.1'
  gem 'factory_girl',       '~> 2.1.2'
  gem 'forgery',            '~> 0.5.0'
  gem 'rspec-rails',        '~> 2.7.0'
  gem 'thin',               '~> 1.3.1'
end

group :development do
  gem 'foreman',            '~> 0.26.1'
  gem 'data_migrations',    '~> 0.0.1'

  unless RUBY_VERSION == '1.9.3' && RUBY_PLATFORM !~ /darwin/
    # will need to install ruby-debug19 manually:
    # gem install ruby-debug19 -- --with-ruby-include=$rvm_path/src/ruby-1.9.3-preview1
    gem 'ruby-debug19', :platforms => :mri_19
  end
end

group :test do
  gem 'jasmine',           '~> 1.1.2'
  gem 'capybara',          '~> 1.0.0'
  gem 'database_cleaner',  '~> 0.7.0'
  gem 'mocha',             '~> 0.10.0'
  gem 'webmock',           '~> 1.7.7'

  # gotta wait for QT 4.7
  # gem 'jasmine-headless-webkit'
end
