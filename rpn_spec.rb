require_relative "calculator"

describe ".evaluate" do
  it "evaluates single numbers" do
    str = "1"
    result = Calculator.eval(str)
    expect(result).to eq 1
  end

  it "performs addition" do
    str = "1 2 +"
    result = Calculator.eval(str)
    expect(result).to eq 3
  end

  it "performs subtraction" do
    str = "1 2 -"
    result = Calculator.eval(str)
    expect(result).to eq -1
  end

  it "performs multiplication" do
    str = "1 2 *"
    result = Calculator.eval(str)
    expect(result).to eq 2
  end

  it "performs division" do
    str = "1 2 /"
    result = Calculator.eval(str)
    expect(result).to eq 0.5
  end

  it "correctly handles long strings" do
    str = "1 2 * 4 + 10 * 5 /"
    result = Calculator.eval(str)
    expect(result).to eq 12
  end

  describe "using provided test cases on the" do
    specify "1st" do
      str = "1 2 +"
      result = Calculator.eval(str)
      expect(result).to eq 3
    end

    specify "2nd" do
      str = "4 2 /"
      result = Calculator.eval(str)
      expect(result).to eq 2
    end

    specify "3rd" do
      str = "2 3 4 + *"
      result = Calculator.eval(str)
      expect(result).to eq 14
    end

    specify "4th" do
      str = "3 4 + 5 6 + *"
      result = Calculator.eval(str)
      expect(result).to eq 77
    end

    specify "5th" do
      str = "13 4 -"
      result = Calculator.eval(str)
      expect(result).to eq 9
    end
  end

  context "should fail" do
    specify "when missing an number" do
      str = "1 +"
      message = nil

      begin
        Calculator.eval(str)
      rescue ArgumentError => err
        message = err.message
      end
        
      expect(message).to eq "incorrect number of arguments"
    end

    specify "when missing a number" do
      str = "1 2"
      message = nil

      begin
        Calculator.eval(str)
      rescue ArgumentError => err
        message = err.message
      end
        
      expect(message).to eq "incorrect number of arguments"
    end

    specify "when input contains non-numbers" do
      str = "a b +"
      message = nil

      begin
        Calculator.eval(str)
      rescue TypeError => err
        message = err.message
      end
        
      expect(message).to eq "invalid number"
    end
  end
end
