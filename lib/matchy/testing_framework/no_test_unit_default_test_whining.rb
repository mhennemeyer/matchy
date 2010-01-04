if Matchy.classic?
  Test::Unit::TestCase.class_eval do
    # No test/unit default_test whining. 
    def default_test # :nodoc:
      instance_eval { @_result.instance_eval { @run_count ||= 0; @run_count -= 1} if defined?(@_result)}
    end
  end
end