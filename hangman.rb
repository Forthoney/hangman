FILEPATH = 'words/google-10000-english-no-swears.txt'

class Word
  def initialize(raw_word)
    @display_word = []
    @raw_word = raw_word
    @missing = raw_word.length

    raw_word.each_char { |_| @display_word.push('_') }
  end

  def guess_char(letter)
    match = false
    @raw_word.each_char.with_index do |char, i|
      if char == letter
        @display_word[i] = letter
        @missing -= 1
        match = true
      end
    end
    match
  end

  def display
    puts @display_word.join(' ')
  end

  def game_done?
    @missing.zero?
  end
end

def load_words
  file = File.open(FILEPATH, 'r')
  words = []
  until file.eof?
    line = file.readline.chomp
    words.push(line) if line.length.between?(5, 12)
  end
  words
end

def valid?(input, used_chars)
  input.match?(/[[:alpha:]]/) && !used_chars.include?(input)
end

def take_input(used_chars)
  puts 'Make your guess'
  guess = gets.chomp

  unless valid?(guess, used_chars)
    puts 'You must select an unchosen alphabet letter'
    guess = take_input(used_chars)
  end

  guess
end

puts 'Starting HANGMAN...'
target = Word.new(load_words.sample)
used_chars = []

target.display
until target.game_done?
  puts 'You have previously guessed'
  puts  used_chars.empty? ? 'nothing' : used_chars.join(', ')
  guess = take_input(used_chars)
  used_chars.push(guess)
  target.guess_char(guess) ? puts('Correct!') : puts('Incorrect!')
  target.display
end
