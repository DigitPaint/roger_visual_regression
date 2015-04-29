module RogerVisualRegression
  class Runner
    def initialize options={}
      check_specifications_exists options
    end

    def call(test, options)
      # Check specifications
      check_specifications_exists(options)

      # Set path where the repository is cloned
      cloned_path = "/tmp/cloned_repository"

      # Get remote repository URL
      giturl = `git config --get remote.origin.url`
      curdir = `pwd`

      # Determine from (previous commit)
      from = `git rev-parse HEAD^`

      cloning = system 'git', 'clone', giturl.delete!("\n"), curdir.delete!("\n") + cloned_path
      if cloning.nil?
        puts "[ERROR] Something went wrong cloning the repository"
      else
        # Done with cloning
        `git fetch origin #{from}`
      end

      # `git clone #{giturl.delete!("\n")} #{curdir.delete!("\n")}/tmp/cloned_repository`
      # `cd #{curdir.delete!("\n")}/tmp/cloned_repository; git checkout #{from.delete!("\n")}`

      # Default from and to
      # from, to = set_default_commit_hashes(options[:from_commit], options[:to_commit])

      #
      RSpec::Core::Runner.run([options[:spec_path] || 'spec'], $stderr, $stdout)
    end

    private

    def check_specifications_exists(options)
      spec_files = Dir.glob("#{options[:spec_path]}/**")
      if spec_files.empty?
        fail "[ERROR] No specifications found to execute. Run `roger test initvisreg` to initialize the base specifications."
      end
    end
  end
end

Roger::Test.register :visual_regression, RogerVisualRegression::Runner
