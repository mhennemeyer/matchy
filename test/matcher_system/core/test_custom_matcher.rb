require File.dirname(__FILE__) + '/..//test_helper.rb'

testing Matchy::CustomMatcher do
  class Foo < Struct.new(:valid)
    def valid?
      valid == true
    end
    
    def items
      [1,2,3]
    end
  end
  
  custom_matcher :matcher_true do |receiver, matcher, args|
    true
  end
  
  custom_matcher :matcher_false do |receiver, matcher, args|
    false
  end
  
  def test_defines_method
    self.class.class_eval do
      custom_matcher :matcher_method do |receiver, matcher, args|
        true
      end
    end
    
    self.should respond_to(:matcher_method)
  end
  
  def test_pass_positive
    1.should matcher_true
  end
  
  def test_fail_positive
    lambda {
      1.should matcher_false
    }.should raise_error
  end
  
  def test_pass_negative
    1.should_not matcher_false
  end
  
  def test_fail_negative
    lambda {
      1.should_not matcher_true
    }.should raise_error
  end
  
  def test_arguments
    actual_args = []
    
    self.class.class_eval do
      custom_matcher :matcher do |receiver, matcher, args|
        actual_args = args
        true
      end
    end
    
    1.should matcher(1,2,3)
    actual_args.should == [1,2,3]
  end
  
  def test_receiver
    actual_receiver = nil
    
    self.class.class_eval do
      custom_matcher :matcher do |receiver, matcher, args|
        actual_receiver = receiver
        true
      end
    end
    
    receiver = 1
    receiver.should matcher
    actual_receiver.should == receiver
  end
  
  def test_calling_receiver_method
    self.class.class_eval do
      custom_matcher :be_nil do |receiver, matcher, args|
        receiver.nil?
      end
    end
    
    nil.should be_nil
    lambda {
      nil.should_not be_nil
    }.should raise_error
    
    'foo'.should_not be_nil
    lambda {
      'foo'.should be_nil
    }.should raise_error
  end
  
  def test_matcher
    self.class.class_eval do
      custom_matcher :be_valid do |receiver, matcher, args|
        matcher.positive_failure_message = "Expected to be valid but wasn't"
        matcher.negative_failure_message = "Expected to not be valid but was"
        receiver.valid?
      end
    end
    
    foo = Foo.new
    
    foo.valid = false
    lambda {
      foo.should be_valid
    }.should raise_error("Expected to be valid but wasn't.")
    
    foo.valid = true
    lambda {
      foo.should_not be_valid
    }.should raise_error("Expected to not be valid but was.")
  end
  
  def test_matcher_with_chained_messages
    self.class.class_eval do
      custom_matcher :have do |receiver, matcher, args|  
  		  count = args[0]
  		  something = matcher.chained_messages[0].name
  		  actual = receiver.send(something).size
  		  matcher.positive_failure_message = "Expected #{receiver} to have #{actual} #{something}, but found #{count} "
  		  actual == count
  		end
    end
    
    foo = Foo.new
    foo.should have(3).items
    
    lambda {
      foo.should have(2).items
    }.should raise_error
  end
end
