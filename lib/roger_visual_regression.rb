# Dependencies
require 'rspec'
require 'rspec/page-regression'

require 'capybara/rspec'
require 'selenium-webdriver'

# Default configuration
RSpec.configure { |c| c.color = true }
Capybara.javascript_driver = :selenium

# Load modules
require "roger_visual_regression/version"
require "roger_visual_regression/commands/initializer"
require "roger_visual_regression/commands/runner"
