# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.


require "spork"

Spork.prefork do

  # Load simplecov on top of everything
  require 'simplecov'

	ENV["RAILS_ENV"] ||= "test"
  
  # Import dependencies
	require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
	require 'cucumber/rails'
	require "cucumber/rspec/doubles"
	require "capybara/poltergeist"

	# Lets you click links with onclick javascript handlers without using @culerity or @javascript
	# require 'cucumber/rails/capybara_javascript_emulation'

	# Capybara does not try to guess what kind of selector you are going to give it, and will always use CSS by default.
	# If you want to use XPath, you'll need to do:
	# Capybara.default_selector = :xpath
	Capybara.default_selector = :css

  # Setup Poltergeist + PhantomJS and set it as default driver
  Capybara.javascript_driver = :poltergeist
	Capybara.register_driver :poltergeist do |app|
	  Capybara::Poltergeist::Driver.new(app, {
      :phantomjs => Phantomjs.path,
      :timeout => 60,
      :inspector => true
    })
	end

 #  Capybara.default_wait_time = 5


	# The default for Capybara.match is :smart.
	# To emulate the behaviour in Capybara 2.0.x, set Capybara.match to :one.
	# To emulate the behaviour in Capybara 1.x, set Capybara.match to :prefer_exact.
	# Capybara.match = :prefer_exact

	# If you set this to false, any error raised from within your app will bubble
	# up to your step definition and out to cucumber unless you catch it somewhere
	# on the way. You can make Rails rescue errors and render error pages on a
	# per-scenario basis by tagging a scenario or feature with the @allow-rescue tag.
	#
	# If you set this to true, Rails will rescue all errors and render error
	# pages, more or less in the same way your application would behave in the
	# default production environment. It's not recommended to do this for all
	# of your scenarios, as this makes it hard to discover errors in your application.
	ActionController::Base.allow_rescue = false

	# If you set this to true, each scenario will run in a database transaction.
	# You can still turn off transactions on a per-scenario basis, simply tagging
	# a feature or scenario with the @no-txn tag. If you are using Capybara,
	# tagging with @culerity or @javascript will also turn transactions off.
	#
	# If you set this to false, transactions will be off for all scenarios,
	# regardless of whether you use @no-txn or not.
	#
	# Beware that turning transactions off will leave data in your database
	# after each scenario, which can lead to hard-to-debug failures in
	# subsequent scenarios. If you do this, we recommend you create a Before
	# block that will explicitly put your database in a known state.
	Cucumber::Rails::World.use_transactional_fixtures = true
	# How to clean your database when transactions are turned off. See
	# http://github.com/bmabey/database_cleaner for more info.
	if defined?(ActiveRecord::Base)
	  begin
	    require 'database_cleaner'
	    DatabaseCleaner.strategy = :truncation
	  rescue LoadError => ignore_if_database_cleaner_not_present
	  end
	end

	AfterConfiguration do |config|
	  DatabaseCleaner.clean
	end
  
  # Enable this hack to discover which dependencies is making your tests slow
  # useful to use together with spork
	# module Kernel
 #    def require_with_trace(*args)
 #      start = Time.now.to_f
 #      @indent ||= 0
 #      @indent += 2
 #      require_without_trace(*args)
 #      @indent -= 2
 #      Kernel::puts "#{' '*@indent}#{((Time.now.to_f - start) * 1000).to_i} #{args[0]}"
 #    end
 #    alias_method_chain :require, :trace
 #  end
end