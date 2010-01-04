# Eval this file with ruby 1.8
require 'rubygems'
require 'test/unit'
require File.dirname(__FILE__) + '/../../../lib/matchy.rb'
class TestAThing < Test::Unit::TestCase
  
  def setup
    @obj = Object.new
  end
  
  # ==
  test "operator eql eql" do
    1.should == 1
  end
  
  test "operator eql eql fails" do
    lambda {1.should == 2}.should raise_error
  end
  
  test "operator eql eql negative" do
    1.should_not == 2
  end
  
  test "operator eql eql negative fails" do
    lambda {1.should_not == 1}.should raise_error
  end
  
  # ===
  test "operator eql eql eql" do
    1.should === 1
  end
  
  test "operator eql eql eql fails" do
    lambda {1.should === 2}.should raise_error
  end
  
  test "operator eql eql eql negative" do
    1.should_not === 2
  end
  
  test "operator eql eql eql negative fails" do
    lambda {1.should_not === 1}.should raise_error
  end
  
  # =~
  test "operator eql match" do
    "string".should =~ /in/
  end
  
  test "operator eql match fails" do
    lambda {"string".should =~ /an/}.should raise_error
  end
  
  test "operator eql match negative" do
    "string".should_not =~ /an/
  end
  
  test "operator eql match negative fails" do
    lambda {"string".should_not =~ /in/}.should raise_error
  end
  
  # <=
  test "operator lt eql" do
    1.should <= 2
  end
  
  test "operator lt eql fails" do
    lambda {1.should <= 0}.should raise_error
  end
  
  test "operator lt eql negative" do
    1.should_not <= 0
  end
  
  test "operator lt eql negative fails" do
    lambda {1.should_not <= 2}.should raise_error
  end
  
  # >=
  test "operator gt eql" do
    1.should >= 0
  end
  
  test "operator gt eql fails" do
    lambda {1.should >= 2}.should raise_error
  end
  
  test "operator gt eql negative" do
    1.should_not >= 2
  end
  
  test "operator gt eql negative fails" do
    lambda {1.should_not >= 0}.should raise_error
  end
  
  # <
  test "operator lt" do
    1.should < 2
  end
  
  test "operator lt fails" do
    lambda {1.should < 0}.should raise_error
  end
  
  test "operator lt negative" do
    1.should_not < 0
  end
  
  test "operator lt negative fails" do
    lambda {1.should_not < 2}.should raise_error
  end
  
  # >
  test "operator gt" do
    1.should > 0
  end
  
  test "operator gt fails" do
    lambda {1.should > 2}.should raise_error
  end
  
  test "operator gt negative" do
    1.should_not > 2
  end
  
  test "operator gt negative fails" do
    lambda {1.should_not > 0}.should raise_error
  end
  
  # be()
  test "be" do
    1.should be(1)
  end
  
  test "be fails" do
    lambda {1.should be(2)}.should raise_error
  end
  
  test "be negative" do
    1.should_not be(2)
  end
  
  test "be negative fails" do
    lambda {1.should_not be(1)}.should raise_error
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
    lambda {@obj.should be_something}.should raise_error(Test::Unit::AssertionFailedError)
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
    lambda {@obj.should_not be_something}.should raise_error(Test::Unit::AssertionFailedError)
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
    lambda {@obj.should be_something(1)}.should raise_error(Test::Unit::AssertionFailedError)
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
    lambda {@obj.should_not be_something(1)}.should raise_error(Test::Unit::AssertionFailedError)
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
  
  # change
  test "change" do
    var = 1
    lambda {var += 1}.should change {var}
  end
  
  test "change fails" do
    var = 1
    lambda do
      lambda { }.should change {var} 
    end.should raise_error
  end
  
  test "change by" do
    var = 1
    lambda {var += 1}.should change {var}.by(1)
  end
  
  test "change by fails" do
    var = 1
    lambda do
      lambda {var += 2}.should change {var}.by(1) 
    end.should raise_error
  end
  
  test "change by at least" do
    var = 1
    lambda {var += 1}.should change {var}.by_at_least(1)
  end
  
  test "change by at least fails" do
    var = 1
    lambda do
      lambda {var += 0.9}.should change {var}.by_at_least(1)
    end.should raise_error
  end
  
  test "change by at most" do
    var = 1
    lambda {var += 1}.should change {var}.by_at_most(1)
  end
  
  test "change by at most fails" do
    var = 1
    lambda do
      lambda {var += 1.1}.should change {var}.by_at_most(1)
    end.should raise_error
  end
  
  test "change from to" do
    var = 1
    lambda {var += 1}.should change {var}.from(1).to(2)
  end
  
  test "change from to fails" do
    var = 1
    lambda do
      lambda {var += 1.1}.should change {var}.from(1).to(2)
    end.should raise_error
  end
  
  # def_matcher
  test "def matcher defines method" do
    def_matcher :method_ do |given, matcher, args|
    end
    self.should respond_to(:method_)
  end
  
  test "def matcher object responds to matches" do
    def_matcher :method_ do |given, matcher, args|
    end
    method_.should respond_to(:matches?)
  end
  
  test "def matcher fail positive" do
    def_matcher :matcher do |given, matcher, args|
      false
    end
    lambda {1.should matcher}.should raise_error
  end
  
  test "def matcher pass positive" do
    def_matcher :matcher do |given, matcher, args|
      true
    end
    1.should matcher
  end
  
  test "def matcher fail negative" do
    def_matcher :matcher do |given, matcher, args|
      true
    end
    lambda {1.should_not matcher}.should raise_error
  end
  
  test "def matcher pass negative" do
    def_matcher :matcher do |given, matcher, args|
      false
    end
    1.should_not matcher
  end
  
  test "def matcher takes arguments" do
    def_matcher :matcher do |given, matcher, args|
      $args = args
      true
    end
    @obj.should matcher(1,2,3)
    $args.should eql([1,2,3])
  end
  
  test "def matcher received method" do
    def_matcher :matcher do |given, matcher, args|
      $msgs = matcher.msgs
      true
    end
    @obj.should matcher.method1
    $msgs[0].name.should eql(:method1)
  end
  
  test "def matcher received method takes args" do
    def_matcher :matcher do |given, matcher, args|
      $msgs = matcher.msgs
      true
    end
    @obj.should matcher.method1(1,2,3)
    $msgs[0].args.should eql([1,2,3])
  end
  
  test "def matcher received method takes block" do
    def_matcher :matcher do |given, matcher, args|
      $msgs = matcher.msgs
      true
    end
    @obj.should matcher.method1 { "Hello, World!"}
    $msgs[0].block.call.should eql("Hello, World!")
  end
  
  test "def matcher received method chained" do
    def_matcher :matcher do |given, matcher, args|
      $msgs = matcher.msgs
      true
    end
    @obj.should matcher.method1(1,2,3) { "Hello, World!"}.
      method2(4,5,6) { "Hello chained messages" }
      
    $msgs[0].name.should eql(:method1)
    $msgs[1].name.should eql(:method2)
    $msgs[0].args.should eql([1,2,3])
    $msgs[1].args.should eql([4,5,6])
    $msgs[0].block.call.should eql("Hello, World!")
    $msgs[1].block.call.should eql("Hello chained messages")
  end
  
  # include/exclude
  test "include" do
    [1,2,3,4].should include(4)
  end
  
  test "include fail" do
    lambda {
      [1,2,3,4].should include(6)
    }.should raise_error(Test::Unit::AssertionFailedError)
  end
  
  test "exclude" do
    [1,2,3,4].should exclude(9)
  end
  
  test "exclude fail" do
    lambda {
      [1,2,3,4].should exclude(4)
    }.should raise_error(Test::Unit::AssertionFailedError)
  end
  
  test "multi include" do
    [1,2,3,4].should include(1,2)
  end
  
  test "multi include fail" do
    lambda {
      [1,2,3,4].should include(6,7,8)
    }.should raise_error(Test::Unit::AssertionFailedError)
  end
  
  test "multi exclude" do
    [1,2,3,4].should exclude(13,14)
  end
  
  test "multi exclude fail" do
    lambda {
      [1,2,3,4].should exclude(2,3,4)
    }.should raise_error(Test::Unit::AssertionFailedError)
  end
  
  test "negative include" do
    [1,2,3,4].should_not include(9)
  end
  
  test "negative include fail" do
    lambda {
      [1,2,3,4].should_not include(4)
    }.should raise_error(Test::Unit::AssertionFailedError)
  end
  
  test "negative exclude" do
    [1,2,3,4].should_not exclude(3)
  end
  
  test "negative exclude fail" do
    lambda {
      [1,2,3,4].should_not exclude(6,7)
    }.should raise_error(Test::Unit::AssertionFailedError)
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
  
  # raise_error
  test "raises error" do
    lambda { raise "FAIL" }.should raise_error
  end
  
  test "raises error fail" do
    lambda {
      lambda { "WIN" }.should raise_error
    }.should raise_error(Test::Unit::AssertionFailedError)
  end
  
  test "raise error negative raises error" do
    lambda { "WIN" }.should_not raise_error
  end
  
  test "raise error negative raises error fail" do
    lambda {
      lambda { raise "FAIL" }.should_not raise_error
    }.should raise_error(Test::Unit::AssertionFailedError)
  end
  
  test "raise error raises specific error" do
    lambda { raise TypeError }.should raise_error(TypeError)
  end
  
  test "raise error raises specific error fail with no error" do
    lambda {
      lambda { "WIN" }.should raise_error(TypeError)
    }.should raise_error(Test::Unit::AssertionFailedError)
  end
  
  test "raise error raises specific error fail with different error" do
    lambda {
      lambda { raise StandardError }.should raise_error(TypeError)
    }.should raise_error(Test::Unit::AssertionFailedError)
  end
  
  test "raise error error fail message" do
    obj = raise_error(TypeError)
    obj.matches?(lambda { raise NameError })
    
    obj.failure_message.should =~ /Expected #<(.*)> to raise TypeError, but NameError was raised instead./
  end
  
  test "raise error error fail message when no error" do
    obj = raise_error(TypeError)
    obj.matches?(lambda { "moop" })
    
    obj.failure_message.should =~ /Expected #<(.*)> to raise TypeError, but none was raised./
  end
  
  test "raise error error negative fail message" do
    obj = raise_error(TypeError)
    obj.matches?(lambda { raise TypeError })
    
    obj.negative_failure_message.should =~ /Expected #<(.*)> to not raise TypeError./
  end
  
  test "raise error string argument message" do
    lambda {raise "message"}.should raise_error("message")
  end
  
  test "string argument message fails no error" do
    lambda do
      lambda { 1 }.should raise_error("message")
      
    end.should raise_error
  end
  
  test "raise error string argument message fails wrong message" do
    lambda do
      lambda { raise "other message" }.should raise_error("message")
    end.should raise_error
  end
  
  test "raise error regexp argument message" do
    lambda {raise "message"}.should raise_error(/essa/)
  end
  
  test "raise error regexp argument message fails no error" do
    lambda do
      lambda { 1 }.should raise_error(/essa/)
    end.should raise_error
  end
  
  test "raise error regexp argument message fails wrong message" do
    lambda do
      lambda { raise "other message" }.should raise_error(/abc/)
    end.should raise_error(/matching/)
  end
  
  # throw
  test "throws symbol" do
    lambda {
      throw :win
    }.should throw_symbol(:win)
  end
  
  test "throws symbol fails with different symbol" do
    lambda {
      lambda {
        throw :fail
      }.should throw_symbol(:win)
    }.should raise_error(Test::Unit::AssertionFailedError)
  end
  
  test "negative throws symbol" do
    lambda {
      "not this time!"
    }.should_not throw_symbol(:win)
  end
  
  test "negative throws symbol fails with different symbol" do
    
    lambda{
      lambda {
        throw :fail
      }.should_not throw_symbol(:fail)
    }.should raise_error(Test::Unit::AssertionFailedError)
  
  end
  
  test "throw fail message" do
    obj = throw_symbol(:fail)
    obj.matches?(lambda { throw :lame })
    
    obj.failure_message.should =~ /Expected #<(.*)> to throw :fail, but :lame was thrown instead./
  end
  
  test "throw fail message when no symbol" do
    obj = throw_symbol(:fail)
    obj.matches?(lambda { "moop" })
    
    obj.failure_message.should =~ /Expected #<(.*)> to throw :fail, but no symbol was thrown./
  end
  
  test "throw negative fail message" do
    obj = throw_symbol(:fail)
    obj.matches?(lambda { throw :fail })
    
    obj.negative_failure_message.should =~ /Expected #<(.*)> to not throw :fail./
  end
end
