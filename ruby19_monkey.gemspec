# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby19_monkey}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["moro"]
  s.date = %q{2009-02-13}
  s.description = %q{Monkey patches to work rails(2.3.0) with ruby 1.9.1}
  s.email = %q{moronatural@gmail.com}
  s.extra_rdoc_files = ["README", "ChangeLog"]
  s.files = ["README", "ChangeLog", "Rakefile", "lib/ruby19_monkey.rb", "rails/init.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/moro/ruby19_monkey}
  s.rdoc_options = ["--title", "ruby19_monkey documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ruby19_monkey}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Monkey patches to work rails(2.3.0) with ruby 1.9.1}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
