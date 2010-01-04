require File.dirname(__FILE__) + '/../test_helper.rb'

class TestModals < Matchy.test_case_class
  def setup
    @expectation = build_matcher() {|r,m,a| true}
    @bad_expectation = build_matcher() {|r,m,a| false}
  end
  
  test "should" do
    3.should(@expectation)
  end
  
  test "will" do
    3.will(@expectation)
  end
  
  test "should not" do
    3.should_not(@bad_expectation)
  end
  
  test "will not" do
    3.will_not(@bad_expectation)
  end
  
  test "wont" do
    3.wont(@bad_expectation)
  end
  
  test "should operator expectation returned" do
    obj = 3.should
    assert_equal Matchy::Expectations::OperatorExpectation, obj.class
  end
  
  
  test "should not operator expectation returned" do
    obj = 3.should_not
    assert_equal Matchy::Expectations::OperatorExpectation, obj.class
  end
end
