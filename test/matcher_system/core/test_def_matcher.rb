require File.dirname(__FILE__) + '/../test_helper.rb'

class TestDefMatcher < Matchy.test_case_class
  
  def setup 
    @obj = Object.new
  end
    
  test "defines method" do
    def_matcher :method_ do |given, matcher, args|
    end
    self.should respond_to(:method_)
  end
  
  test "object responds to matches" do
    def_matcher :method_ do |given, matcher, args|
    end
    method_.should respond_to(:matches?)
  end
  
  test "fail positive" do
    def_matcher :matcher do |given, matcher, args|
      false
    end
    lambda {1.should matcher}.should raise_error
  end
  
  test "pass positive" do
    def_matcher :matcher do |given, matcher, args|
      true
    end
    1.should matcher
  end
  
  test "fail negative" do
    def_matcher :matcher do |given, matcher, args|
      true
    end
    lambda {1.should_not matcher}.should raise_error
  end
  
  test "pass negative" do
    def_matcher :matcher do |given, matcher, args|
      false
    end
    1.should_not matcher
  end
  
  test "takes arguments" do
    def_matcher :matcher do |given, matcher, args|
      $args = args
      true
    end
    @obj.should matcher(1,2,3)
    $args.should eql([1,2,3])
  end
  
  test "received method" do
    def_matcher :matcher do |given, matcher, args|
      $msgs = matcher.msgs
      true
    end
    @obj.should matcher.method1
    $msgs[0].name.should eql(:method1)
  end
  
  test "received method takes args" do
    def_matcher :matcher do |given, matcher, args|
      $msgs = matcher.msgs
      true
    end
    @obj.should matcher.method1(1,2,3)
    $msgs[0].args.should eql([1,2,3])
  end
  
  test "received method takes block" do
    def_matcher :matcher do |given, matcher, args|
      $msgs = matcher.msgs
      true
    end
    @obj.should matcher.method1 { "Hello, World!"}
    $msgs[0].block.call.should eql("Hello, World!")
  end
  
  test "received method chained" do
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
end
