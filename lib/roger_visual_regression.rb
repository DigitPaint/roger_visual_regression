module RogerVisualRegression; end

# Dependencies
require "roger/test"
require 'rspec'
require 'rspec/page-regression'

require 'capybara/rspec'
require 'selenium-webdriver'

# Default configuration
RSpec.configure { |c| c.color = true }
Capybara.javascript_driver = :selenium

# Load modules
require File.dirname(__FILE__) + "/roger_visual_regression/version"
require File.dirname(__FILE__) + "/roger_visual_regression/generator"
require File.dirname(__FILE__) + "/roger_visual_regression/runner"
