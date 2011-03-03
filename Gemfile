source :rubygems

group :development do
  gem 'backports', '~> 1.18.2'
  gem 'jeweler',   '~> 1.5.2'
  gem 'rake',      '~> 0.8.7'
  gem 'rspec',     '~> 1.3.1', :git => 'git://github.com/dkubb/rspec.git'
end

group :jruby do
  platform :jruby do
    gem 'jruby-openssl', '~> 0.7.2'
  end
end

group :benchmarks do
  gem 'rbench', '~> 0.2.3'
end

platforms :mri_18 do
  group :quality do
    gem 'activesupport', '~> 2.3.10'
    gem 'flay',          '~> 1.4.1'
    gem 'flog',          '~> 2.4.0', :git => 'git://github.com/dkubb/flog.git'
    gem 'heckle',        '~> 1.4.3'
    gem 'json',          '~> 1.4.6'
    gem 'metric_fu',     '~> 2.0.1'
    gem 'mspec',         '~> 1.5.17'
    gem 'rcov',          '~> 0.9.9'
    gem 'reek',          '~> 1.2.8', :git => 'git://github.com/dkubb/reek.git'
    gem 'roodi',         '~> 2.1.0'
    gem 'ruby2ruby',     '=  1.2.2'
    gem 'yard',          '~> 0.6.4'
    gem 'yardstick',     '~> 0.2.0'
  end
end
