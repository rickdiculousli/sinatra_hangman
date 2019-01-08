require 'io/console'
class Hangman
  attr_accessor :slots, :try, :unused_chrs, :used_chrs, :word, :max_tries, :victory

  def initialize(round_max = 7)
    @max_tries = round_max
    @dictionary =  File.open('files/5desk.txt', 'r'){ |file| file.readlines }
    new_game
  end

  def new_game
    @slots = []
    @try = 0
    @unused_chrs = ('A'..'Z').to_a
    @used_chrs = []
    @word = ''
    @victory = false
    @word = @dictionary.select{|w| w.length >= 5 || w.length <= 12}.sample.upcase.strip
    word.length.times{ @slots << "_"}
  end

  def in_game?
    @try < @max_tries && !@victory
  end

  def end_game
    puts 'The game is over!'
    puts "You have #{@victory ? 'won!' : 'lost'}"
    puts "The word was #{@word}"
  end

  def play_round(input)
    correct = false
    @word.each_char.with_index do |char, index|
      if char.eql? input
        @slots[index] = char
        correct = true
      end 
    end
    @try += 1 unless correct
    if @slots.join("").eql? @word
      @victory = true
    end
  end
end