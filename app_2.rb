require "bundler"
Bundler.require

require_relative "lib/game"
require_relative "lib/player"
require_relative "lib/human_player"

#Méthode d'introcduction qui initialise les différents participants
def intro
  puts "-------------------------------------------------"
  puts "|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts "-------------------------------------------------"

  puts "Choisi un nom de guerrier !"
  print "> "
  player_name = gets.chomp #Le joueur choisi son nom
  $human_player = HumanPlayer.new(player_name) #On crée son personnage

  #On vient créer deux ennemies
  $player1 = Player.new("Josiane")
  $player2 = Player.new("José")

  #On les place dans un array pour faciliter la manipulation
  $enemies = [$player1, $player2]
end

#Méthode de combat
def combat
  #Tant que personne n'est mort (le joueur ou les 2 ennemies), on continue le combat
  while $enemies[0].life_points > 0 || $enemies[1].life_points > 0 && $human_player.life_points > 0
    menu #On appel le menu
    puts
    choice_user #On appel le choix du joueur
    puts
    computer_combat #On fait le combat des ordinateur
    sleep(4)
  end
  #Quand le combat est fini, on affiche si le joueur a perdu ou gagné
  puts
  puts "La partie est finie"
  puts $human_player.life_points <= 0 ? "Loser ! Tu as perdu !" : "BRAVO, TU AS GAGNE !"
end

#Méthode pour afficher le menu
def menu
  system("clear")
  puts "--------------------------------"
  puts "Voici l'état du joueur"
  $human_player.show_state
  puts
  puts "Quelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner "
  puts
  puts "Attaquer un joueur en vue :"
  if $enemies[0].life_points > 0 #Si l'ennemi est en vie on affiche ses points de vie
    puts "0 - #{$enemies[0].name} a #{$enemies[0].life_points} points de vie"
  else #Si ses points de vie tombent à 0, on affiche qu'il est mort
    puts "#{$enemies[0].name} est mort(e)"
  end
  if $enemies[1].life_points > 0
    puts "1 - #{$enemies[1].name} a #{$enemies[1].life_points} points de vie"
  else
    puts "#{$enemies[1].name} est mort(e)"
  end
  puts
  print "> "
  $user_input = gets.chomp #Choix de l'utilisateur
end

#Méthode pour effectuer les actions du choix du joueur
def choice_user
  case $user_input
  when "a" #Option pour chercher une arme
    puts
    $human_player.search_weapon
  when "s" #Option pour chercher de la vie
    puts
    $human_player.search_health_pack
  when "0" #Option pour attaquer le joueur 1
    puts
    $human_player.attacks($enemies[0])
  when "1" #Option pour attaquer le joueur 2
    puts
    $human_player.attacks($enemies[1])
  end
end

#Méthode de combat de ordinateur
def computer_combat
  $enemies.each do |user| #Chaque ordinateur va combattre le joueur
    if user.life_points > 0
      puts "Les enemis t'attaquent !"
      user.attacks($human_player)
    end
  end
end

#Méthode globale
def perform
  intro
  combat
end

perform