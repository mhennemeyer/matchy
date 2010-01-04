require File.dirname(__FILE__) + '/../test_helper.rb'

class TestExpectationBuilder < Matchy.test_case_class
  
  def setup
    @obj = Object.new
  end
  
  test "should" do
    exp = Matchy::ExpectationBuilder.build_expectation(true, nil, @obj)
    exp.send(:==, @obj)
  end
  
  test "should fails" do
    expect_1 = Matchy::ExpectationBuilder.build_expectation(true, nil, 1)
    lambda {expect_1.send(:==, 2)}.should raise_error
  end
  
  test "should not" do
    exp = Matchy::ExpectationBuilder.build_expectation(false, nil, @obj)
    exp.send(:==, 1)
  end
  
  test "should not fails" do
    expect_not_1 = Matchy::ExpectationBuilder.build_expectation(false, nil, 1)
    lambda {expect_not_1.send(:==, 1)}.should raise_error
  end
end
