$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'matcher_system/expectation_builder'
require 'matcher_system/modals'
require 'matcher_system/matcher_builder'
require 'matcher_system/def_matcher'
require 'matcher_system/custom_matcher'

require 'matcher_system/built_in/enumerable_expectations'
require 'matcher_system/built_in/error_expectations'
require 'matcher_system/built_in/truth_expectations'
require 'matcher_system/built_in/operator_expectations'
require 'matcher_system/built_in/change_expectations'