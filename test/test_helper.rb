if RUBY_VERSION.to_f < 1.9
  require 'rubygems'
  require 'test/unit'
else
  require 'minitest/unit'
end

require File.dirname(__FILE__) + '/../lib/matchy.rb'
