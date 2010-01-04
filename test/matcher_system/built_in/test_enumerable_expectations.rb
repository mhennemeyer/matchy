require File.dirname(__FILE__) + '/../test_helper.rb'

testing "Enumerable Expectations" do
  test "include" do
    [1,2,3,4].should include(4)
  end
  
  test "include fail" do
    lambda {
      [1,2,3,4].should include(6)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "exclude" do
    [1,2,3,4].should exclude(9)
  end
  
  test "exclude fail" do
    lambda {
      [1,2,3,4].should exclude(4)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "multi include" do
    [1,2,3,4].should include(1,2)
  end
  
  test "multi include fail" do
    lambda {
      [1,2,3,4].should include(6,7,8)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "multi exclude" do
    [1,2,3,4].should exclude(13,14)
  end
  
  test "multi exclude fail" do
    lambda {
      [1,2,3,4].should exclude(2,3,4)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative include" do
    [1,2,3,4].should_not include(9)
  end
  
  test "negative include fail" do
    lambda {
      [1,2,3,4].should_not include(4)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative exclude" do
    [1,2,3,4].should_not exclude(3)
  end
  
  test "negative exclude fail" do
    lambda {
      [1,2,3,4].should_not exclude(6,7)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "include fail message" do
    obj = include(1)
    obj.matches?([4,5,6])
    
    obj.failure_message.should be("Expected [4, 5, 6] to include [1].")
  end
  
  test "include negative fail message" do
    obj = include(1)
    obj.matches?([4,5,6])
    
    obj.negative_failure_message.should be("Expected [4, 5, 6] to not include [1].")
  end
  
  test "exclude fail message" do
    obj = exclude(4)
    obj.matches?([4,5,6])
    
    obj.failure_message.should be("Expected [4, 5, 6] to exclude [4].")
  end
  
  test "exclude negative fail message" do
    obj = exclude(4)
    obj.matches?([4,5,6])
    
    obj.negative_failure_message.should be("Expected [4, 5, 6] to not exclude [4].")
  end
end
