require 'rubygems'
require 'minitest/unit'
FORCE_MINITEST = true
load File.dirname(__FILE__) + '/../../../lib/matchy.rb'

MiniTest::Unit.autorun

class TestAThing < MiniTest::Unit::TestCase
  test "equal equal" do
    1.should == 1
  end
  
  test "equal equal fails" do
    #1.should == 2 
    lambda{ 1.should == 2 }.should raise_error
  end
  
  test "equal equal negative" do
    1.should_not == 2
  end
  
  test "equal equal negative fails" do
    lambda{ 1.should_not == 1 }.should raise_error
  end
end
