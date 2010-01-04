require File.dirname(__FILE__) + '/../test_helper.rb'

testing "change matcher" do
  setup do
    @var = 1
  end
  
  test "passing" do
    lambda {@var += 1}.should change {@var}
  end
  
  test "change fails" do
    lambda do
      lambda { }.should change {@var} 
    end.should raise_error
  end
  
  test "change by" do
    lambda {@var += 1}.should change {@var}.by(1)
  end

  test "change by fails" do
    lambda do
      lambda {@var += 2}.should change {@var}.by(1) 
    end.should raise_error
  end

  test "change by at least" do
    lambda {@var += 1}.should change {@var}.by_at_least(1)
  end

  test "change by at least fails" do
    lambda do
      lambda {@var += 0.9}.should change {@var}.by_at_least(1)
    end.should raise_error
  end

  test "change by at most" do
    lambda {@var += 1}.should change {@var}.by_at_most(1)
  end

  test "change by at most fails" do
    lambda do
      lambda {@var += 1.1}.should change {@var}.by_at_most(1)
    end.should raise_error
  end

  test "change from to" do
    lambda {@var += 1}.should change {@var}.from(1).to(2)
  end

  test "change from to fails" do
    lambda do
      lambda {@var += 1.1}.should change {@var}.from(1).to(2)
    end.should raise_error
  end
end
