require File.dirname(__FILE__) + '/../test_helper.rb'

testing Matchy::MatcherBuilder do
  include Matchy::MatcherBuilder

  def setup
    @obj = Object.new
  end
  
  test "matcher responds to matches" do
    block = lambda {|given, matcher, args| true}
    build_matcher(:m, &block).should respond_to(:matches?)
  end
  
  test "fail positive" do
    block = lambda {|given, matcher, args| false}
    lambda {@obj.should build_matcher(:m, &block)}.should raise_error
  end
  
  test "pass positive" do
    block = lambda {|given, matcher, args| true}
    @obj.should build_matcher(:m, &block)
  end
  
  test "fail negative" do
    block = lambda {|given, matcher, args| true}
    lambda {@obj.should_not build_matcher(:m, &block)}.should raise_error
  end
  
  test "pass negative" do
    block = lambda {|given, matcher, args| false}
    @obj.should_not build_matcher(:m, &block)
  end
  
  test "takes arguments" do
    block = lambda {|given, matcher, args| $args = args; true}
    @obj.should build_matcher(:m,[1,2,3], &block)
    $args.should eql([1,2,3])
  end
  
  test "received method" do
    block = lambda {|given, matcher, args| $msgs = matcher.msgs; true}
    @obj.should build_matcher(:m, &block).method1
    $msgs[0].name.should eql(:method1)
  end
  
  test "received method takes args" do
    block = lambda {|given, matcher, args| $msgs = matcher.msgs; true}
    @obj.should build_matcher(:m, &block).method1(1,2,3)
    $msgs[0].args.should eql([1,2,3])
  end
  
  test "received method takes block" do
    block = lambda {|given, matcher, args| $msgs = matcher.msgs; true}
    @obj.should build_matcher(:m, &block).method1 { "Hello, World!"}
    $msgs[0].block.call.should eql("Hello, World!")
  end
  
  test "received method chained" do
    block = lambda {|given, matcher, args| $msgs = matcher.msgs; true}
    @obj.should build_matcher(:m, &block).method1(1,2,3) { "Hello, World!"}.
      method2(4,5,6) { "Hello chained messages" }
      
    $msgs[0].name.should eql(:method1)
    $msgs[1].name.should eql(:method2)
    $msgs[0].args.should eql([1,2,3])
    $msgs[1].args.should eql([4,5,6])
    $msgs[0].block.call.should eql("Hello, World!")
    $msgs[1].block.call.should eql("Hello chained messages")
  end

end
