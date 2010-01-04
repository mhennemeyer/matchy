require File.dirname(__FILE__) + "/../test_helper.rb"

testing "top level EG contains a before and deeper nested group" do
  
  setup do
    @var_defined_in_top_level_e_g = "Horst"
  end

  testing "2" do
    testing "3" do
      testing "4" do
        testing "5" do
          test "should know var_defined_in_top_level_e_g" do
            @var_defined_in_top_level_e_g.should be("Horst")
          end
        end
      end
    end
  end
end