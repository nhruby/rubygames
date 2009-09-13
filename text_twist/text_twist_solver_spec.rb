require 'spec'
 
Dir.glob(File.join(File.dirname(__FILE__), '*.rb')).each do |file|
  require(file) unless file.match(/_spec.rb$/)
end
 
# find all the other words of 3 or more characters
# that we can make from the one specified
describe TextTwistSolver do
  before(:each) do
    @twister  = TextTwistSolver.new(File.join(File.dirname(__FILE__), "wordlist.txt"))
    @solution = @twister.results_for("crack")
  end

  it "should return the an array of words we can make" do
    @solution.length.should == 5
    ["rack", "arc", "ark", "car"].each do |word|
      @solution.should include(word)
    end
  end
end
