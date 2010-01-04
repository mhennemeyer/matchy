require File.dirname(__FILE__) + '/../test_helper.rb'

testing "Operator Expectations" do

  test "equals (==)" do
    3.should == 3
  end
  
  test "equals fails" do
    lambda {
      3.should == 5
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative equals" do
    3.should_not == 4
  end
  
  test "negative equals fails" do
    lambda {
      3.should_not == 3
    }.should raise_error(Matchy.assertion_failed_error)
  end

  test "less than (<)" do
    3.should < 5
  end
  
  test "less than fails" do
    lambda {
      4.should < 3
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "less than equals" do
    3.should_not < 2
  end
  
  test "negative less than fails" do
    lambda {
      4.should_not < 5
    }.should raise_error(Matchy.assertion_failed_error)
  end 
  
  # GREATER THAN (>)
  test "greater than" do
    3.should > 2
  end
  
  test "greater than fails" do
    lambda {
      4.should > 5
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "greater than equals" do
    3.should_not > 5
  end
  
  test "negative greater than fails" do
    lambda {
      4.should_not > 3
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  # LESS THAN EQUAL (<=)
  test "less than equal" do
    3.should <= 5
  end
  
  test "less than equal equal" do
    3.should <= 3
  end
  
  test "less than equal fails" do
    lambda {
      4.should <= 3
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative less than equal" do
    3.should_not <= 2
  end
  
  test "negative less than equal fails" do
    lambda {
      4.should_not <= 5
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  # GREATER THAN EQUALS (>=)
  test "greater than equal" do
    3.should >= 2
  end
  
  test "greater than equal equals" do
    3.should >= 3
  end
  
  test "greater than equal fails" do
    lambda {
      4.should >= 5
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative greater than equal equals" do
    3.should_not >= 5
  end
  
  test "negative greater than equal fails" do
    lambda {
      4.should_not >= 3
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  # MATCHES (=~)
  test "matches" do
    "hey world".should =~ /world/
  end
  
  test "matches fails" do
    lambda {
      "d00d ur 1337".should =~ /world/
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative matches" do
    "1337@age".should_not =~ /434/
  end
  
  test "negative matches fails" do
    lambda {
      "it's a freak out!".should_not =~ /freak/
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "fail message" do
    obj = Matchy::Expectations::OperatorExpectation.new(3, true)
    
    def obj.flunk(msg)
      msg
    end
    
    (obj == 4).should == "Expected 3 to == 4."
  end
  
  test "negative fail message" do
    obj = Matchy::Expectations::OperatorExpectation.new(3, false)
    
    def obj.flunk(msg)
      msg
    end
    
    (obj == 3).should == "Expected 3 to not == 3."
  end
end
