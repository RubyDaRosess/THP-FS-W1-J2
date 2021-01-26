class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left

  #Métode pour initialiser le jeu. On vient donner un nom pour le joueur et le nombre d'ennemis
  def initialize(player_name, nb)
    @players_left = nb #Nombre d'ennemis
    @enemies_in_sight = [] #Création de l'array
    @human_player = HumanPlayer.new(player_name) #Création du joueur
    5.times do |n| #On commence par mettre 5 ennemis dans l'array
      @enemies_in_sight << Player.new("Ennemi #{n}")
    end
    @players_left
  end

  #Méthode pour supprimer un joueur si il meurt
  def kill_player(player)
    @enemies_in_sight.reject! { |k| k.name == player.name }
    @players_left -= 1 #On retire un joueur du total
  end

  #Méthode pour checker si la partie est toujours en cours
  def is_still_ongoing?
    return false if @human_player.life_points <= 0 #Arret si le joueur n'a plus de vie
    return false if ((@enemies_in_sight.select {|enemy| enemy.life_points > 0}.size == 0) && @players_left==0) #Arret si il n'y a plus d'ennemis en vie
    return true
  end

  #Méthode pour montrer l'état du joueur et des ordinateurs
  def show_players
    @human_player.show_state
    puts "Il reste #{@enemies_in_sight.size} ennemis en vue"
  end

  #Méthode pour afficher le menu
  def menu
    puts "--------------------------------"
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner "
    puts
    puts "Attaquer un joueur en vue :"
    @enemies_in_sight.size.times do |n| #Affichage de tous les ennemis présents
      if @enemies_in_sight[n].life_points > 0
        puts "#{n} - #{@enemies_in_sight[n].name} a #{@enemies_in_sight[n].life_points} points de vie"
      end
    end
  end

  #Méthode pour effectuer les actions du choix du joueur
  def menu_choice(usr_choice)
    case usr_choice
    when "a" #Option pour chercher une arme
      puts
      @human_player.search_weapon
    when "s" #Option pour chercher de la vie
      puts
      @human_player.search_health_pack
    else #Option pour attaquer les ennemis
      if (usr_choice.to_i.between?(0, @enemies_in_sight.size-1)) #Choisi un nombre
        puts
        @human_player.attacks(@enemies_in_sight[usr_choice.to_i]) #Attaque l'ennemis choisi
        if @enemies_in_sight[usr_choice.to_i].life_points <= 0 #Si l'ennemis n'a plus de points de vue on le tue
          kill_player(@enemies_in_sight[usr_choice.to_i])
        end
      end
    end
  end

  #Méthode pour la phase d'attaque des ennemis
  def enemies_attack
    puts "Les ennemis t'attaquent !"
    @enemies_in_sight.each { |enemy| enemy.attacks(@human_player) if is_still_ongoing? } #Si la partie est toujours en cours, les ennemis attaquent
  end

  #Méthode pour cloturer le jeu
  def end
    puts "La partie est finie"
    if (@human_player.life_points > 0) && (@enemies_in_sight.size == 0) #Si il n'y a plus d'ennmis, le joueur gagne
      puts "BRAVO, TU AS GAGNE !"
    else #Sinon, il perds
      puts "Loser ! Tu as perdu !"
    end
  end

  #Méthode pour rajouter des ennemis
  def new_players_in_sight
    puts
    if @players_left == @enemies_in_sight.size
      puts "Tous les ennemis sont déjà en vue"
    else
      nb_enemy = rand(1..6) #On défini un nombre aléatoire
      case nb_enemy
      when 1 #Si 1, aucun ennemi en plus
        puts "Aucun ennemi n'est apparu"
      when 2..4 #1 ennemis en plus
        puts "Un nouvel ennemi apparaît !"
        @enemies_in_sight << Player.new("Ennemi #{@enemies_in_sight.size}")
      else #2 ennemis en place
        puts "Deux ennemis sont apparues !"
        2.times do |n|
          @enemies_in_sight << Player.new("Ennemi #{@enemies_in_sight.size + n}")
        end
      end
    end
  end
end