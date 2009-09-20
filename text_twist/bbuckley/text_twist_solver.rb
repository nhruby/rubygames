

class TextTwistSolver
  def initialize(file)
    d = File.readlines(file)
    @dic = d.map{|x| x.chomp! }
  end
  
  def results_for(word)
    a = word.each_char.to_a
    ans = []     
    3.upto(word.length) do |n|   
      a.permutation(n) do |aa|
        w = aa.join
        ans << w if @dic.include?(w)
      end
    end
    ans.uniq
  end

end