# This integration testing script generates a rails app in a tmp folder, scaffolds a resource
# and runs some tests.

# What rails versions (>= 2.3) should be supported?
# Note that the appropriate gems have to be installed.
SUPPORTED_RAILS_VERSIONS = ["2.3.5"]

current_dir = File.expand_path(File.dirname(__FILE__))

# remove rails root if already existing
`cd #{current_dir}/tmp && rm -rf rails_root`

# generate rails app
`cd #{current_dir}/tmp && rails rails_root`

# generate models, controllers, helpers, mailers
`cd #{current_dir}/tmp/rails_root && script/generate scaffold my_model && script/generate mailer MyMailer confirm && rake db:migrate && rake db:test:prepare`

for supported_rails_version in SUPPORTED_RAILS_VERSIONS

  RAILS_GEM_VERSION = supported_rails_version
  # require rails_test_helper
  require current_dir + "/tmp/rails_root/test/test_helper.rb"

  # require matchy
  require current_dir + "/../../../lib/matchy.rb"
  Matchy.load_testing_framework


  # Tests
  
  testing MyModelsController, :type => ActionController::TestCase do
    
    setup do
      get :index
    end
    
    test "should get index" do
      @response.should be_success
      assigns(:my_models).should_not be_nil
    end

     testing "nested TestCase" do
       test "should still work" do
          @response.should be_success
          assigns(:my_models).should_not be_nil
       end
     end

     test "knows about my_models_path" do
       my_models_path.should eql("/my_models")
     end
  end

  module MyModelsHelper
    def helper_method
      '<be value="helpful" />'
    end
  end

  testing MyModelsHelper, :type => ActionView::TestCase do

    test "is helpful" do
      helper_method.should =~ /helpful/
    end
  
    testing "nested TestCase" do
      test "is still helpful" do
        helper_method.should =~ /helpful/
      end
    end  
  end
end