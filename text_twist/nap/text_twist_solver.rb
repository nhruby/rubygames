class TextTwistSolver
  class FileNotFound < StandardError; end

  MIN_CHARS = 3

  attr_reader :dictionary

  def initialize(dictionary_file)
    @dictionary = Dictionary.new

    if File.exists?(dictionary_file)
      File.open(dictionary_file, "r").each do |line|
        @dictionary.add_word(line.chomp)
      end 
    else
      raise FileNotFound, "Dictionary file does not exist!"
    end
  end

  # return other words that can be created from the source word
  def results_for(source_word, length = source_word.split("").length)
    if length >= MIN_CHARS
      chars = source_word.split("")

      # start with longest word, work back to shortest
      result = dictionary.filter_by_length(length).filter_by_characters(chars).to_a
      result += results_for(source_word, length - 1)
    else
      []
    end
  end

  class Dictionary
    def initialize(array = [])
      @data = array
    end

    def to_a
      @data
    end

    def add_word(word)
      @data << word
    end

    # filter dictionary words, keeping only those words whose length matches the specified value
    def filter_by_length(length)
      filtered = @data.select { |word| word.length == length }
      Dictionary.new(filtered)
    end

    # filter dictionary words, keeping only those words that contain only the characters in the array
    def filter_by_characters(characters)
      filtered = @data.select do |word| 
        word_can_be_created_from(word, characters)
      end

      Dictionary.new(filtered)
    end

    private

    # can the given word be constructed from the array of characters?
    def word_can_be_created_from(word, chars)
      available_chars = chars.dup
      word_chars = word.split("")

      word_chars.each do |char|
        if pos = available_chars.index(char)
          available_chars.delete_at(pos)
        else
          return false
        end
      end

      true
    end
  end
end
