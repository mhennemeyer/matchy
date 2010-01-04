require File.dirname(__FILE__) + '/../test_helper.rb'

class Exister
  def initialize(what)
    @what = what
  end
  
  def exist?
    @what
  end
end

testing "Truth Expectations" do
  
  def setup
    @obj = Object.new
  end
  
  test "equal" do
    3.should equal(3)
  end

  test "negative equal" do
    instance = String.new
    
    instance.should_not equal(String.new)
  end
  
  test "equal fail" do
    lambda {
      3.should equal(4)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative equal fail" do
    lambda {
      3.should_not equal(3)
    }.should raise_error(Matchy.assertion_failed_error)
  end

  test "eql" do
    3.should eql(3)
  end
  
  test "eql array" do
    [1,2,3].should eql([1,2,3])
  end
  
  test "negative eql" do
    3.should_not eql(9)
  end
  
  test "eql fail" do
    lambda {
      3.should eql(13)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative eql fail" do
    lambda {
      3.should_not eql(3)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "exists" do
    thing = Exister.new(true)
    thing.should exist
  end
  
  test "negative exists" do
    thing = Exister.new(false)
    thing.should_not exist
  end
  
  test "exists fail" do
    lambda {
      thing = Exister.new(false)
      thing.should exist
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative exists fail" do
    lambda {
      thing = Exister.new(true)
      thing.should_not exist
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "be" do
    true.should be(true)
  end
  
  test "be array" do
    [1,2,3].should be([1,2,3])
  end
  
  test "negative be" do
    true.should_not be(false)
  end
  
  test "be fail" do
    lambda {
      true.should be(false)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "be close" do
    (5.0 - 2.0).should be_close(3.0)
  end
  
  test "be close with delta" do
    (5.0 - 2.0).should be_close(3.0, 0.2)
  end
  
  test "be close fail" do
    lambda {
      (19.0 - 13.0).should be_close(33.04)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "be close with delta fail" do
    lambda {
      (19.0 - 13.0).should be_close(6.0, 0.0)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "satisfy" do
    13.should satisfy(lambda {|i| i < 15})
  end
  
  test "negative satisfy" do
    13.should_not satisfy(lambda {|i| i < 10})
  end
  
  test "satisfy fail" do
    lambda {
      13.should satisfy(lambda {|i| i > 15})
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative satisfy fail" do
    lambda {
      13.should_not satisfy(lambda {|i| i < 15})
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "equal fail message" do
    obj = equal(4)
    obj.matches?(5)
    
    obj.failure_message.should be("Expected 5 to return true for equal?, with '4'.")
  end
  
  test "equal negative fail message" do
    obj = equal(5)
    obj.matches?(5)
    
    obj.negative_failure_message.should be("Expected 5 to not return true for equal?, with '5'.")
  end
  
  test "eql fail message" do
    obj = eql(4)
    obj.matches?(5)
    
    obj.failure_message.should be("Expected 5 to return true for eql?, with '4'.")
  end
  
  test "eql negative fail message for eql" do
    obj = eql(5)
    obj.matches?(5)
    
    obj.negative_failure_message.should be("Expected 5 to not return true for eql?, with '5'.")
  end
  
  test "exist fail message" do
    obj = exist
    obj.matches?(Exister.new(false))
    
    obj.failure_message.should =~ /Expected #<(.*)> to return true for exist?./
  end
  
  test "exist negative fail message" do
    obj = exist
    obj.matches?(Exister.new(true))
    
    obj.negative_failure_message.should =~ /Expected #<(.*)> to not return true for exist?./
  end
  
  test "be close fail message" do
    obj = be_close(3.0)
    obj.matches?(6.0)
    
    obj.failure_message.should be("Expected 6.0 to be close to 3.0 (delta: 0.3).")
  end
  
  test "be close negative fail message" do
    obj = be_close(5.0)
    obj.matches?(5.0)
    
    obj.negative_failure_message.should be("Expected 5.0 to not be close to 5.0 (delta: 0.3).")
  end
  
  test "be fail message" do
    obj = be(4)
    obj.matches?(5)
    
    obj.failure_message.should be("Expected 5 to be 4.")
  end
  
  test "be negative fail message" do
    obj = be(5)
    obj.matches?(5)
    
    obj.negative_failure_message.should be("Expected 5 to not be 5.")
  end
  
  test "satisfy fail message" do
    obj = satisfy(lambda {|x| x == 4})
    obj.matches?(6)
    
    obj.failure_message.should be("Expected 6 to satisfy given block.")
  end
  
  test "eql negative fail message for matches" do
    obj = satisfy(lambda {|x| x == 4})
    obj.matches?(4)
    
    obj.negative_failure_message.should be("Expected 4 to not satisfy given block.")
  end
  
  test "kind of" do
    3.should be_kind_of(Fixnum)
  end
  
  test "kind of fail" do
    lambda {
      3.should be_kind_of(Hash)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative kind of" do
    3.should_not be_kind_of(Hash)
  end
  
  test "negative kind of fail" do
    lambda {
      3.should_not be_kind_of(Fixnum)
    }.should raise_error(Matchy.assertion_failed_error)
  end

  test "respond to" do
    "foo".should respond_to(:length)
  end
  
  test "respond to fail" do
    lambda {
      "foo".should respond_to(:nonexistant_method)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative respond to" do
    "foo".should_not respond_to(:nonexistant_method)
  end
  
  test "negative respond to fail" do
    lambda {
      "foo".should_not respond_to(:length)
    }.should raise_error(Matchy.assertion_failed_error)
  end
  
  # be_something
  test "positive be something method missing pass" do
    def @obj.something?
      true
    end
    @obj.should be_something
  end
  
  test "positive be something method missing fails" do
    def @obj.something?
      false
    end
    lambda {@obj.should be_something}.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative be something method missing pass" do
    def @obj.something?
      false
    end
    @obj.should_not be_something
  end
  
  test "negative be something method missing fails" do
    def @obj.something?
      true
    end
    lambda {@obj.should_not be_something}.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "be something method missing fail message" do
    obj = "foo"
    def obj.something?
      true
    end
    matcher_obj = be_something
    obj.should matcher_obj
    
    matcher_obj.failure_message.should be("Expected \"foo\" to return true for something?, with 'no args'.")
  end
  
  test "be something method missing negative fail message" do
    obj = "foo"
    def obj.something?
      false
    end
    matcher_obj = be_something
    obj.should_not matcher_obj
    
    matcher_obj.negative_failure_message.should =~ /Expected \"foo\" to not return true for something?/
  end
  
  # be_something(arg)
  test "positive be something with arg method missing pass" do
    def @obj.something?(arg)
      true
    end
    @obj.should be_something(1)
  end
  
  test "positive be something with arg method missing fails" do
    def @obj.something?(arg)
      false
    end
    lambda {@obj.should be_something(1)}.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "negative be something method missing pass" do
    def @obj.something?(arg)
      false
    end
    @obj.should_not be_something(1)
  end
  
  test "negative be something method missing fails" do
    def @obj.something?(arg)
      true
    end
    lambda {@obj.should_not be_something(1)}.should raise_error(Matchy.assertion_failed_error)
  end
  
  test "be something method missing fail message" do
    obj = "foo"
    def obj.something?(arg)
      true
    end
    matcher_obj = be_something(1)
    obj.should matcher_obj
    
    matcher_obj.failure_message.should be("Expected \"foo\" to return true for something?, with '1'.")
  end
  
  test "be something method missing negative fail message" do
    obj = "foo"
    def obj.something?(arg)
      false
    end
    matcher_obj = be_something(1)
    obj.should_not matcher_obj
    
    matcher_obj.negative_failure_message.should be("Expected \"foo\" to not return true for something?, with '1'.")
  end

end
