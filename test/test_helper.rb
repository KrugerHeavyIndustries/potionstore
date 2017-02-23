ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require 'rails/test_help'
require 'minitest/reporters'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]   

class ActiveSupport::TestCase

  set_fixture_class :coupons => Admin::Coupon

  fixtures :all
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Add more helper methods to be used by all tests here...
  def print_exchange(tag)
    puts "\n\n#{@request.request_method} #{@request.path} \n"
    puts "#{tag} request:\n#{@request.request_parameters}" if @request.request_parameters.length > 0
    puts "#{tag} response:\n#{@response.body}"
  end
end

#if Rails::VERSION::MAJOR < 4
#  #Fix fixtures with foreign keys, fixed in Rails4
#  class ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
#    def disable_referential_integrity #:nodoc:
#      if supports_disable_referential_integrity? then
#        execute(tables.collect { |name| "ALTER TABLE #{quote_table_name(name)} DISABLE TRIGGER USER" }.join(";"))
#      end
#      yield
#    ensure
#      if supports_disable_referential_integrity? then
#        execute(tables.collect { |name| "ALTER TABLE #{quote_table_name(name)} ENABLE TRIGGER USER" }.join(";"))
#      end
#    end
#  end
#end
