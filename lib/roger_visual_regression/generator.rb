# <- hekje
module Roger
  # <- hekje
  module Cli; end
end

require "roger/cli/generate"
require "roger/cli/command"
require "roger/generators"

module RogerVisualRegression
  class Generator < Roger::Generators::Base
    include Thor::Actions

    desc "Creates base spec files for visual regression"
    class_option(
      :spec_path,
      type: :string,
      default: "specs/",
      desc: "Path where spec files should be stored"
    )

    class_option(
      :html_path,
      type: :string,
      desc: "HTML Path where the html files are located"
    )

    def call
      if options[:html_path].nil?
        options[:html_path] = @project.options[:html_path]
      end

      check_existing_spec_files(options)

      # Delete current specs found in folder
      delete_current_specs!(options)

      create_base_specs!

      say "\n\n"
      say_status "OK", "Created base specifications in /#{options[:spec_path]}"
    end

    private

    def check_existing_spec_files(options={})
      spec_files = Dir.glob("#{options[:spec_path]}/**")
      unless spec_files.empty?
        if !(prompt("Path '#{options[:spec_path]}' not empty, do you want to continue? [Y/n]: ") =~ /^y(es)?$/i)
          say_status "OK", "Stopped initializing spec folder", :red
          exit(0)
        end
      end
    end

    def delete_current_specs!(options={})
      FileUtils.rm_rf(Dir.glob("#{options[:spec_path]}/*"))
    end

    def create_base_specs!
      html_files = Dir[File.join(@project.options[:html_path], "/**/*.html{.erb}")]
      html_files.each do |html_file|
        # Keep original path
        original_file_path = html_file.dup
        html_file.slice! /^html/i

        # Create folder structure
        spec_file_path = FileUtils.mkpath(options[:spec_path] + File.dirname(html_file)).first

        # Create file with content
        html_file = File.expand_path(File.basename(html_file, File.extname(html_file)))
        spec_file = (spec_file_path + "/" + File.basename(html_file, ".html") + "_spec.rb")

        # Add content to the files for base testing
        FileUtils.touch(spec_file)
        open(spec_file, 'a') do |f|
          f << "describe \"Base test for #{original_file_path}\", :type => :feature, :js => true do\n"
          f << "  before(:each) do\n"
          f << "    visit \"http://localhost:#{@project.server.server_options[:Port]}#{html_file}\"\n"
          f << "    sleep 2\n"
          f << "  end\n"
          f << "  it { page.should match_expectation } \n"
          f << "end"
        end

        say_status "OK", "Created spec for #{html_file}"
      end
    end

    def prompt question
      print(question)
      $stdin.gets.strip
    end

  end
end

Roger::Generators.register RogerVisualRegression::Generator
