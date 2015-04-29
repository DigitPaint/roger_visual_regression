module RogerVisualRegression
  class Generator < Roger::Generators::Base
    include Thor::Actions

    desc "Creates base spec files for visual regression"
    class_option(
      :path,
      type: :string,
      default: "/specs/",
      desc: "Path where spec files should be stored"
    )

    def call
      check_existing_spec_files(options)

      # Delete current specs found in folder
      delete_current_specs!(options)

      create_base_specs!(test)

      puts "Created base specifications in /#{options[:spec_path]}"
    end

    private

    def check_existing_spec_files(options={})
      spec_files = Dir.glob("#{options[:spec_path]}/**")
      unless spec_files.empty?
        if !(prompt("Path '#{options[:spec_path]}' not empty, do you want to continue? [Y/n]: ") =~ /^y(es)?$/i)
          puts "Stopped initializing spec folder"
          exit(1)
        end
      end
    end

    def delete_current_specs!(options={})
      FileUtils.rm_rf(Dir.glob("#{options[:spec_path]}/*"))
    end

    def create_base_specs!(test)
      html_files = Dir[File.join(test.project.options[:html_path], "/**/*.html")]
      html_files.each do |html_file|
        # Keep original path
        original_file_path = html_file.dup
        html_file.slice! /^html/i

        # Create folder structure
        spec_file_path = FileUtils.mkpath("spec" + File.dirname(html_file)).first

        # Create file with content
        spec_file = (spec_file_path + "/" + File.basename(html_file, ".html") + "_spec.rb")
        FileUtils.touch(spec_file)

        # Add content to the files for base testing
        open(spec_file, 'a') do |f|
          f << "describe \"Base test for #{original_file_path}\", :type => :feature, :js => true do\n"
          f << "  before(:each) do\n"
          f << "    visit \"http://localhost:#{test.project.server.server_options[:Port]}#{html_file}\"\n"
          f << "    sleep 2\n"
          f << "  end\n"
          f << "  it { page.should match_expectation } \n"
          f << "end"
        end
      end
    end

    def prompt question
      print(question)
      $stdin.gets.strip
    end

  end
end

Roger::Generators.register RogerVisualRegression::Generator
