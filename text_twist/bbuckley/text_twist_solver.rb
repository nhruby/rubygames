require 'set'

class TextTwistSolver  
  def initialize(file)
    @dictionary = File.readlines(file).map(&:chomp).to_set
  end    
  
  def results_for(word) 
    # intersection of sets: a word's scrabble and the dictionary 
    @dictionary & word.scrabble(3..word.length)
  end   
end

class String  
  # a String's scrabble is the set of possible words that can be made from its letters
  # "test".scrabble =>
  # <SortedSet: {"e", "es", "est", "estt", "et", "ets", "etst", "ett", 
  # "etts", "s", "se", "set", "sett", "st", "ste", "stet", "stt", "stte", 
  # "t", "te", "tes", "test", "tet", "tets", "ts", "tse", "tset", "tst", 
  # "tste", "tt", "tte", "ttes", "tts", "ttse"}>
  # optional sizes parameter (type integer or range) produces a subset of these
  def scrabble(sizes = 1..length)
    sizes = (sizes..sizes) if Integer === sizes
    letters = split ""
    SortedSet.new.tap do |set|
      sizes.each do |n|
        set.merge(letters.permutation(n).map(&:join).to_set)
      end
    end    
  end
  
end    
