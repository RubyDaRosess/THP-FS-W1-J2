class Player
  attr_accessor :name, :life_points

  #Métode pour initialiser le jeu. On vient donner un nom pour le joueur
  def initialize(chr_name)
    @name = chr_name
    @life_points = 10 #On initialise les points de vie
  end

  #Méthode pour montrer l'état du joueur
  def show_state
    puts "#{@name} a #{@life_points} points de vie"
  end

  #Méthode pour infliger des dégats
  def get_damage(dmg)
    @life_points -= dmg #On retire les dommages subits
    if @life_points <= 0 #Si le nombre de points de vie est en dessous le 0, le joueur meurt
      puts
      puts "Le joueur #{@name} a été tué !"
    end
  end

  #Méthode pour l'attaque
  def attacks(player_attacked)
    puts "#{@name} attaque #{player_attacked.name}"
    dmg_p1 = compute_damage #On récupère les dommages de la méthode compute_damage
    puts "#{dmg_p1} points de dommages infligés"
    player_attacked.get_damage(dmg_p1) #On vient appeler les méthode get_damage pour retirer les points de vie
  end

  #Méthode pour définir aléatoirement les dommages
  def compute_damage
    return rand(1..6)
  end
end
