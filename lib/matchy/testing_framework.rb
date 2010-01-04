require 'test/unit'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "testing_framework/no_test_unit_default_test_whining"
require "testing_framework/test_case_class_methods"
require "testing_framework/kernel_extension"
require "testing_framework/functions"