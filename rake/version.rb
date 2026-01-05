namespace :version do
  VERSION_FILE = 'VERSION'
  desc "Bump major version (X.0.0)"
  task :bump_major do
    bump_version(:major)
  end
  desc "Bump minor version (x.X.0)"
  task :bump_minor do
    bump_version(:minor)
  end
  desc "Bump patch version (x.x.X)"
  task :bump_patch do
    bump_version(:patch)
  end
  def bump_version(level)
    current = File.read(VERSION_FILE).strip
    major, minor, patch = current.split('.').map(&:to_i)
    case level
    when :major
      major += 1
      minor = 0
      patch = 0
    when :minor
      minor += 1
      patch = 0
    when :patch
      patch += 1
    end
    new_version = "#{major}.#{minor}.#{patch}"
    File.write(VERSION_FILE, new_version + "\n")
    puts "Bumped version from #{current} to #{new_version}"
  end
end
