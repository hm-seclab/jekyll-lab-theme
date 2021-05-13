# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "lab-theme"
  spec.version       = "0.1.0"
  spec.authors       = ["Thomas Schreck"]
  spec.email         = ["tom@schreck-thomas.de"]

  spec.summary       = "Write a short summary, because Rubygems requires one."
  spec.homepage      = "https://github.com/hm-seclab/jekyll-lab-theme"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README|_config\.yml|(_projects|_publications|_persons)/index.html|_plugins)!i) }

  spec.add_runtime_dependency "jekyll", "~> 4.2"
  spec.add_runtime_dependency "webrick", "~> 1.7"
end
