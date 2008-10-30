desc "Rename a controller, use options as: from=todo to=tasks"
namespace :rename2 do
  task :controller do
    if ENV['FROM'].nil?
      puts "Please specify the original controller name, like so: from=todo" and return if ENV['FROM'].nil?
    elsif ENV['TO'].nil?
      puts "Please specify the original controller name, like so: to=tasks" and return if ENV['TO'].nil?
    elsif ENV['FROM'] == ENV['TO']
      puts "To and from are the same"
    else
      require 'fileutils'
      from = ENV['FROM']
      to = ENV['TO']
      puts "Renaming the view files to the #{to} folder"
      puts "#{from.underscore}"
      puts "#{from}"
      system("git mv app/views/#{from.underscore.downcase} app/views/#{to.underscore.downcase}")

      puts "Renaming the controller the #{to}_controller.rb"
      system("git mv app/controllers/#{from.underscore.downcase}_controller.rb app/controllers/#{to.underscore.downcase}_controller.rb")

      puts "Renaming the spec to #{to}_controller_test.rb"
      system("git mv spec/controllers/#{from.underscore.downcase}_controller_spec.rb spec/controllers/#{to.underscore.downcase}_controller_spec.rb")
      system("git mv spec/helpers/#{from.underscore.downcase}_helper_spec.rb spec/helpers/#{to.underscore.downcase}_helper_spec.rb")

      puts "Renaming the helper to #{to}_controller_test.rb"
      system("git mv app/helpers/#{from.underscore.downcase}_helper.rb app/helpers/#{to.underscore.downcase}_helper.rb")



      rbfiles = File.join("**", "*.rb")

      Dir.glob(rbfiles).each do |file|
        buffer = File.new(file,'r').read.gsub(/#{from}/,to)
        File.open(file,'w') {|fw| fw.write(buffer)}
      end


      puts "~~~~~~~~~~~
      Do not forget to edit your controller [/app/controllers/#{to}_controller.rb]:
        class #{to.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }}Controller < ApplicationController
      Your helper [/app/helpers/#{to}_helper.rb]:
        class #{to.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }}Helper
      Your test functional [/test/functional/#{to}_controller_test.rb]:
        class #{to.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }}ControllerTest < ActionController::TestCase

      Also do not forget to update your routes and all your singular and plural instances of routes. And their child routes.
      "
    end
  end

  task :model do
    if ENV['FROM'].nil?
      puts "Please specify the original controller name, like so: from=todo" and return if ENV['FROM'].nil?
    elsif ENV['TO'].nil?
      puts "Please specify the original controller name, like so: to=tasks" and return if ENV['TO'].nil?
    elsif ENV['FROM'] == ENV['TO']
      puts "To and from are the same"
    else
      require 'fileutils'
      from = ENV['FROM']
      to = ENV['TO']
      puts "Renaming the model file"

      puts "Renaming the model to #{to.sub(/s$/, "")}"
      system("git mv app/models/#{from.underscore.downcase}.rb app/models/#{to.underscore.downcase}.rb")
      system("git mv spec/models/#{from.underscore.downcase}_spec.rb spec/models/#{to.underscore.downcase}_spec.rb")
      system("git mv spec/fixtures/#{from.underscore.downcase.pluralize}.yml spec/fixtures/#{to.underscore.downcase.pluralize}.yml")

      rbfiles = File.join("**", "*.{rb,haml,yml,spec}")

      Dir.glob(rbfiles).each do |file|
        buffer = File.new(file,'r').read.gsub(/#{from}/,to)
        File.open(file,'w') {|fw| fw.write(buffer)}
      end

      Dir.glob(rbfiles).each do |file|
        buffer = File.new(file,'r').read.gsub(/#{from.underscore.downcase}/,to.underscore.downcase)
        File.open(file,'w') {|fw| fw.write(buffer)}
      end
    end
  end
end