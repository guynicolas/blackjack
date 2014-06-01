# Interactive procedural blackjack game

# Calculating total 

def calculate_total(cards)
  # [['S', '6'], ['C', '8'], ...]
  value_array = cards.map{ |e| e[1] }

  total = 0
  value_array.each do |card_value|
    if card_value == "A"        # Aces 
      total += 11
    elsif card_value.to_i == 0  # Q, J, and K
      total += 10
    else 
      total += card_value.to_i  # numbered cards
    end 
  end 

  # Correct for Aces 
  value_array.select{|e| e == "A"}.count.times do 
  total -= 10 if total > 21
  end

  total
end 

suits = ['H', 'C', 'D', 'S']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Q', 'J', 'K', 'A']
deck = suits.product(cards)
deck.shuffle!

# Deal cards

playercards = []
dealercards = []

playercards << deck.pop
dealercards << deck.pop
playercards << deck.pop
dealercards << deck.pop

playertotal = calculate_total(playercards)
dealertotal = calculate_total(dealercards)

puts "Player dealt: #{playercards[0]} and #{playercards[1]} with a total of #{playertotal}."
puts "Dealer dealt: #{dealercards[0]} and #{dealercards[1]} with a total of #{dealertotal}."

if playertotal == 21
  puts "Congratulations, you hit the blackjack. You won!"
  exit
end 

if dealertotal == 21
  puts "Sorry, the Dealer wins. You lost!"
  exit
end

# Player's turn

while playertotal < 21
  puts "What would you like to do? 1) hit 2) stay"
  answer = gets.chomp
  if !['1', '2'].include?(answer)
    puts "Error: you must enter either 1 or 2!"
    next
  end 

  if answer == '2'
    puts "You chose to stay."
    break
  end 

  # hit 
  newcard = deck.pop
  playercards << newcard
  playertotal = calculate_total(playercards)
  puts "Player dealt: #{newcard} and the new total is #{playertotal}."
  if playertotal == 21
    puts "Congratulations, you hit the blackjack. You won!"
    exit
  elsif playertotal > 21
    puts "Sorry, it looks you busted. You lost!"
    exit
  end
end 

# Dealer's turn 

while dealertotal < 17
  newcard = deck.pop
  dealercards << newcard
  dealertotal = calculate_total(dealercards)
  puts "Dealer dealt: #{newcard} and the new total is #{dealertotal}."
  if dealertotal == 21
    puts "Sorry, Dealer hit the blackjack. You lost!"
    exit
  elsif dealertotal > 21
    puts "Congratulations, Dealer is busted! You won!"
    exit
  end  
end 

# Compare hands 

puts "Player's cards: "
playercards.each do |card|
  puts "=> #{card}"
end 
puts "Your total is: #{playertotal}."

puts "Dealer's cards: "
dealercards.each do |card|
  puts "=> #{card}"
end 
puts "Dealer's total is: #{dealertotal}."

if playertotal > dealertotal
  puts "Congratulations, you won!"
  exit
elsif dealertotal > playertotal
  puts "Sorry, Dealer wins. You lost!"
  exit
else 
  puts "It's a tie!"
  exit
end 



