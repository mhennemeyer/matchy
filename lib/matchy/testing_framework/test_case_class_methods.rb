module Testing
  # The methods defined in this module are available
  # inside the TestCases.
  module TestCaseClassMethods
    attr_accessor :desc, :setup_chained, :teardown_chained
    @desc ||= ""
    def setup_chained # :nodoc:
      @setup_chained || lambda {}
    end

    def teardown_chained # :nodoc:
      @teardown_chained || lambda {}
    end

    def testcases
      @@testcases ||= []
      @@testcases
    end

    def own_tests
      @own_tests || []
    end

    def all_tests
      @@_tests || []
    end

    # == Run before each Test.
    # The code in the block attached to this method will be run before each
    # test in all subsequent, eventually nested testcases.
    def setup(&block)
      passed_through_setup = self.setup_chained
      self.setup_chained = lambda { instance_eval(&passed_through_setup);instance_eval(&block) }
      define_method :setup, &self.setup_chained
    end

    # == Run after each Test.
    # The code in the block attached to this method will be run after each
    # test in all subsequent, eventually nested testcases.
    def teardown(&block)
      passed_through_teardown = self.teardown_chained
      self.teardown_chained = lambda {instance_eval(&block);instance_eval(&passed_through_teardown) }
      define_method :teardown, &self.teardown_chained
    end

    # == Define a TestCase.
    def testing desc, &block
      cls = Class.new(self)

      cls.reset_tests!
      Object.const_set(self.name + desc.to_s.split(/\W+/).map { |s| s.capitalize }.join, cls)
      cls.setup_chained = self.setup_chained
      cls.teardown_chained = self.teardown_chained
      cls.desc = self.desc + " " + desc
      cls.tests($1.constantize) if defined?(Rails) && 
        self.name =~ /^(.*(Controller|Helper|Mailer))Test/ && 
          self < ActiveSupport::TestCase
      cls.class_eval(&block)
      self.testcases << cls
    end

    # == Define a test.
    def test desc, &block
      self.setup {}
      desc = Testing::Functions.make_constantizeable(desc)
      if block_given?
        test = "test_#{desc.gsub(/\W+/, '_').downcase}"
        define_method(test, &lambda {$current_spec = self; instance_eval(&block)})
        (@@_tests ||= []) << test.to_sym
        (@own_tests ||= []) << test.to_sym
      end
      self.teardown {}
    end

    def reset_tests!
      defined?(@@_tests) ? @@_tests.each {|t| undef_method(t) if method_defined?(t)} : nil
    end
  end # TestCaseClassMethods
end