require File.dirname(__FILE__) + "/../test_helper.rb"

testing "top level" do
  
  setup do
    @horst = "Horst"
  end
  
  test "example1" do
    @horst.should eql("Horst")
  end
  
  testing "second level" do
    
    setup do
      @inge = "Inge"
      @horst = "NoHorst!"
    end
    
    test "there should be NoHorst" do
      @horst.should eql("NoHorst!")
    end
    
    test "Inge should be here" do
      @inge.should be("Inge")
    end  
  end
  
  test "Horst should still be Horst" do
    @horst.should be("Horst")
  end
end
