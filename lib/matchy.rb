$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

unless defined?(Test::Unit) || defined?(MiniTest)
  raise "No Testing library present! Either Test::Unit or MiniTest must be required before loading matchy" 
end

# Matchy should work with either test/unit or minitest
module Matchy
  class << self
    def classic?
      # We have to decide if we really have a 
      # suite of MiniTest Tests.
      # Rails for example defines MiniTest, so to only check for
      # defined?(MiniTest) would be malicious
      !defined?(FORCE_MINITEST) && defined?(Test::Unit) && defined?(Test::Unit::TestCase) && !minitest_tu_shim?
    end

    def minitest?
      !classic? && !minitest_tu_shim?
    end

    def minitest_tu_shim?
      defined?(Test::Unit::TestCase) && defined?(MiniTest::Assertions) && Test::Unit::TestCase < MiniTest::Assertions
    end

    def assertions_module
      minitest? ? MiniTest::Assertions : Test::Unit::Assertions
    end

    def test_case_class
      minitest? ? MiniTest::Unit::TestCase : Test::Unit::TestCase
    end

    def assertion_failed_error
      minitest? ? MiniTest::Assertion : Test::Unit::AssertionFailedError
    end
    
    def load_testing_framework
      require 'matchy/testing_framework'
    end
  end
end
MiniTest::Unit.autorun if Matchy.minitest?

require 'matchy/version'
require 'matchy/matcher_system'

# Track the current testcase and 
# provide it to the operator matchers.
Matchy.test_case_class.class_eval do
  alias_method :old_run_method_aliased_by_matchy, :run
  def run(whatever, *args, &block)
    $current_test_case = self
    old_run_method_aliased_by_matchy(whatever, *args, &block)
  end
end

Matchy.test_case_class.send(:include, Matchy::Expectations::TestCaseExtensions)

include Matchy::DefMatcher

