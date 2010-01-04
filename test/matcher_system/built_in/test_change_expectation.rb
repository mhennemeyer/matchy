require File.dirname(__FILE__) + '/../test_helper.rb'

testing "change matcher" do
  setup do
    @var = 1
  end
  
  test "passing" do
    lambda {@var += 1}.should change {@var}
  end
  
  def test_change_fails
    lambda do
      lambda { }.should change {@var} 
    end.should raise_error
  end
  
  def test_change_by    
    lambda {@var += 1}.should change {@var}.by(1)
  end

  def test_change_by_fails    
    lambda do
      lambda {@var += 2}.should change {@var}.by(1) 
    end.should raise_error
  end

  def test_change_by_at_least    
    lambda {@var += 1}.should change {@var}.by_at_least(1)
  end

  def test_change_by_at_least_fails    
    lambda do
      lambda {@var += 0.9}.should change {@var}.by_at_least(1)
    end.should raise_error
  end

  def test_change_by_at_most    
    lambda {@var += 1}.should change {@var}.by_at_most(1)
  end

  def test_change_by_at_most_fails    
    lambda do
      lambda {@var += 1.1}.should change {@var}.by_at_most(1)
    end.should raise_error
  end

  def test_change_from_to    
    lambda {@var += 1}.should change {@var}.from(1).to(2)
  end

  def test_change_from_to_fails
    lambda do
      lambda {@var += 1.1}.should change {@var}.from(1).to(2)
    end.should raise_error
  end
end