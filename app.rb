require "bundler"
Bundler.require

require_relative "lib/game"
require_relative "lib/player"
require_relative "lib/human_player"

#Initialisation des joueurs
player1 = Player.new("Marc")
player2 = Player.new("Julie")

#On lance le combat qui dure jusqu'à ce qu'un des joueur arrive à 0
while player1.life_points > 0 || player2.life_points > 0
  puts "--------------------------------"
  puts "Voici l'état des joueurs"
  player1.show_state
  player2.show_state
  puts
  #Phase d'attaque
  puts "C'est l'heure du dududududuel !"
  player1.attacks(player2)
  if player2.life_points <= 0 #Condition pour que le J1 gagne
    puts
    puts "#{player1.name} a gagné !"
    break #Si le joueur gagne, le jeu s'arrête
  end
  player2.attacks(player1)
  if player1.life_points <= 0 #Condition pour que le J2 gagne
    puts
    puts "#{player2.name} a gagné !"
    break #Si le joueur gagne, le jeu s'arrête
  end
end