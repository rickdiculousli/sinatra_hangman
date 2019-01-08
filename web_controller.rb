require 'sinatra'
require 'sinatra/reloader' if development?
require './hangman'
h = Hangman.new
get '/' do
    unless params['reset'].nil?
        h.new_game
    end
    unless params['letter'].nil?
        round_input = h.unused_chrs.delete(params['letter'])
        h.used_chrs.push(params['letter'])
        h.play_round(round_input)
        h.used_chrs = h.used_chrs.uniq
    end
    link = "./images/hangman/#{h.try}.jpg"
    if h.in_game?
        winlose = ''
        word = h.slots.join(" ")
        unused = create_buttons(h.unused_chrs)
        used = h.used_chrs.join(", ")
    else
        winlose = h.victory ? "You Win!" : "You Lose!"
        word = "Word is: " + h.word
        unused = ''
        used = h.used_chrs.join(", ")
    end
    erb :index, :locals => {:word => word,
                            :unused => unused,
                            :used => used,
                            :link => link,
                            :winlose => winlose}
end

def create_buttons(array)
    string = ''
    array.each do |chr|
        string << "<input type='submit' name='letter' value=#{chr}> "
    end
    string
end