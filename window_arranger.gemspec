require_relative "lib/window_arranger/version"

Gem::Specification.new do |spec|
  spec.name          = "window_arranger"
  spec.version       = WindowArranger::VERSION
  spec.authors       = ["labocho"]
  spec.email         = ["labocho@penguinlab.jp"]

  spec.summary       = "Arrange window positions on macOS"
  spec.description   = "Arrange window positions on macOS"
  spec.homepage      = "https://github.com/labocho/window_arranger"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/labocho/window_arranger"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r(^exe/)) {|f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
