module Imb

  # Provides paths to gem directories
  module ProjectDirs

    # Returns the root directory of the gem
    # @return [String] absolute path to gem root
    def self.project_dir
      File.expand_path('../..', __dir__)
    end

    # Returns the bundled fonts directory
    # @return [String] absolute path to fonts/ directory
    def self.font_dir
      File.join(project_dir, 'fonts')
    end

  end
end
