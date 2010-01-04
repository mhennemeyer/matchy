require File.dirname(__FILE__) + "/../test_helper.rb"
require 'rubygems'
require "minitest/unit"
MiniTest::Unit.autorun
class TestInterop < MiniTest::Unit::TestCase
  def test_method
    assert(true)
  end
end

testing "A classic testcase definition inside a testing context" do
  
  class TestInterop2 < MiniTest::Unit::TestCase
    def test_method
      assert(true)
    end
  end

end