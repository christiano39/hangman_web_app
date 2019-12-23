require 'sinatra'
require 'sinatra/reloader'

def select_random_word
    dictionary = File.readlines("dictionary.txt")
    random_index = get_new_random_number
    begin
        dictionary[random_index].to_s.gsub!(/\r/,"").gsub!(/\n/,"").trim
    rescue
        dictionary[random_index].to_s
    end
end

def select_good_word
    word = select_random_word
    unless word.length > 5 && word.length <= 12
        word = select_random_word
    end
    word.downcase
end

def get_new_random_number
    filename = "dictionary.txt"
    line_count = `wc -l "#{filename}"`.strip.split(' ')[0].to_i
    rand(line_count)
end

def is_match?(word, char)
    if word.include? char
        true
    else
        false
    end
end

def secret_word_to_underscores(secret_word)
    length = secret_word.length - 1
    new_word = "".rjust(length * 2, "_ ")
    new_word = new_word.split(" ")
end

def get_indices(word, char)
    word = word.split("")
    indices = word.each_index.select{|i| word[i] == char}
end

def reset_game
    $secret_word = select_good_word
    $guessed_letters = []
    $number_of_guesses_remaining = 8
    $guessed_word = secret_word_to_underscores($secret_word)
    $message = ""
end

$secret_word = select_good_word
$guessed_letters = []
$number_of_guesses_remaining = 8
$guessed_word = secret_word_to_underscores($secret_word)
$message = ""

get '/' do
    user_guess = params['user_guess']
    cheat = "Cheat mode enabled: The secret word is #{$secret_word}"
    game_over = false
    if !user_guess.nil? && user_guess =~ /[A-Za-z]/
        user_guess = user_guess.downcase
        if is_match?($secret_word, user_guess)
            indices = get_indices($secret_word, user_guess)
            indices.each do |i|
                $guessed_word[i] = user_guess
            end
        else
            unless $guessed_letters.include? user_guess
                $guessed_letters.push(user_guess)
                $number_of_guesses_remaining -= 1
            end
        end
    end
    if $number_of_guesses_remaining == 0
        game_over = true
        $message = "Darn! Out of guesses. The secret word was #{$secret_word}."
    elsif !$guessed_word.include? '_'
        game_over = true
        $message = "Nice job! You guessed the word #{$secret_word}."
    end
    if params['reset']
        reset_game
        game_over = false
    end
    erb :index, :locals => {:secret_word => $secret_word, 
        :guessed_word => $guessed_word, :guessed_letters => $guessed_letters,
        :number_of_guesses_remaining => $number_of_guesses_remaining,
        :message => $message, :game_over => game_over, :cheat => cheat}
end