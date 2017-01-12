# frozen_string_literal: true
guard :rspec, cmd: 'bundle exec rspec' do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Tokogen only has spec for mail module so far
  # Use it cause it's better than nothing.
  watch(%r{^lib/(.+)\.rb$}) { 'spec/tokogen_spec.rb' }
end
