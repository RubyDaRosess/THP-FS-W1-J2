require "bundler"
Bundler.require

require_relative "lib/game"
require_relative "lib/player"
require_relative "lib/human_player"

#Initalisation du programme
def init
  system "clear"
  puts "-------------------------------------------------"
  puts "|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts "-------------------------------------------------"
  puts
  puts "Choisi un nom de guerrier !"
  print "> "
  return gets.chomp #Choix du nom du joueur
end

#Méthode globale
def perform
  my_game = Game.new(init, 10) #Initialisation de la partie
  while (my_game.is_still_ongoing? == true) #Tant que personne n'est mort, le jeu continue
    system "clear"
    my_game.show_players #Montre l'état des joueurs
    my_game.menu #Affiche le menu
    puts
    puts "Fais ton choix :"
    print "> "
    user_input = gets.chomp #Le joueur fait son choix
    my_game.menu_choice(user_input) #On fait l'action par rapport au choix du joueur
    puts
    my_game.enemies_attack #Phase d'attaque des ennemis
    my_game.new_players_in_sight #Ajout des ennemis
    gets
  end
  my_game.end #Fin du jeu
end

perform