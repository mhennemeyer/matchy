module Matchy
  module CustomMatcher
    include Matchy::MatcherBuilder
    def custom_matcher(matcher_name, &block)
      define_method matcher_name do |*args|
        build_matcher(matcher_name, args, &block)
      end
    end
  end
end