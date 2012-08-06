guard 'spork', :rspec_env => { 'ENV' => 'test' } do
  # Gemfile
  watch('Gemfile')            { 'bundle install' }

  # application
  watch('application.rb')

  # config yml files
  watch(%r{^config/.+\.yml$})

  # cucumber
  # watch(%r{features/support/}) { :cucumber }
end

guard 'rspec', :version => 2 do
  # providers
  watch(%r{^lib/stoplight/providers/(.+)\.rb$})     { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch(%r{^spec/unit/(.+)_spec\.rb$})              { |m| "spec/unit/#{m[1]}_spec.rb" }

  # rspec
  watch('spec/spec_helper.rb')  { "spec" }
end

guard 'coffeescript', :input => 'app/assets/javascripts', :output => 'public/javascripts', :all_on_start => true

guard 'compass', :configuration_file => 'config/compass.rb', :all_on_start => true do
  watch(%r{(.*)\.s[ac]ss$})
end
