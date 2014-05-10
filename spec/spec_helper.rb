require 'bundler'
Bundler.require
require 'active_support'
require 'active_support/core_ext'
require 'yaml'
require 'hashie'

TEST_DIRECTORY = 'rspec_test_dir'

RSpec.configure do |config|
  config.before :suite do
    Laurel.create_project(TEST_DIRECTORY)
    Dir.chdir(TEST_DIRECTORY)
  end

  config.after :suite do
    Dir.chdir('../')
    FileUtils.rm_r(TEST_DIRECTORY)
  end
end
