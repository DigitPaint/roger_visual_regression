module RogerVisualRegression
  class Runner

    def call(test, options)
      # Check specifications
      check_specifications_exists(options)
      RSpec::Core::Runner.run([options[:spec_path].to_s || 'spec'], $stderr, $stdout)
    end

    private

    def check_specifications_exists(options)
      if(File.directory?(options[:spec_path]))
        spec_files = Dir.glob("#{options[:spec_path]}/**")
        if spec_files.empty?
          puts "[ERROR] No specifications found to execute. Run `roger generate visual_regression` to initialize the base specifications."
          exit(0)
        end
      end
    end
  end
end

Roger::Test.register :visual_regression, RogerVisualRegression::Runner
