require File.dirname(__FILE__) + "/../test_helper.rb"

testing Testing::Functions do
  
  testing "determine_class_name(name)" do
    test "Horst -> Horst" do
       Testing::Functions::determine_class_name("Horst").should eql("Horst")
    end
    
    test "HorstTest -> HorstTest" do
       Testing::Functions::determine_class_name("HorstTest").should eql("HorstTest")
    end
    
    test "HorstTest Hello -> HorstTestHello" do
       Testing::Functions::determine_class_name("HorstTest Hello").should eql("HorstTestHello")
    end
    
    test "Horst test hello -> HorstTestHello" do
       Testing::Functions::determine_class_name("Horst test hello").should eql("HorstTestHello")
    end
  end
  
  testing "#make_constantizeable(string)" do
    test "returns arg if arg is not a string" do
       Testing::Functions.make_constantizeable(1).should eql(1)
    end
    
    test "removes nonword chars" do
       Testing::Functions.make_constantizeable("@hello").should eql("hello")
    end
    
    test "removes leading numbers" do
       Testing::Functions.make_constantizeable("11_hello").should eql("_hello")
    end
    
    test "doesn't remove inline whitespace" do
       Testing::Functions.make_constantizeable("h e l l o").should eql("h e l l o")
    end
    
    test "removes leading whitespace" do
       Testing::Functions.make_constantizeable(" hello").should eql("hello")
       Testing::Functions.make_constantizeable("1 hello").should eql("hello")
       Testing::Functions.make_constantizeable("1 1 @ hello").should eql("hello")
    end
  end
end