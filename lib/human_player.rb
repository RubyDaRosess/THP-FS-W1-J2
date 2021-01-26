class HumanPlayer < Player
  attr_accessor :weapon_level

  #Métode pour initialiser le jeu. On vient donner un nom pour le joueur
  def initialize(chr_name)
    super(chr_name)
    @life_points = 10000 #On initialise les points de vie
    @weapon_level = 1 #On initialise le niveau de l'arme
  end

  #Méthode pour montrer l'état du joueur
  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  #Méthode pour définir aléatoirement les dommages puis on vient multiplier les dégats par le niveau de l'arme
  def compute_damage
    return rand(1..6) * @weapon_level
  end

  #Méthode pour permettre au joueur de prendre une meilleure arme
  def search_weapon
    new_weapon = rand(1..6) #On détermine aléatoirement le niveau de l'arme trouvée
    puts "Tu as trouvé une arme de niveau #{new_weapon}"
    if new_weapon > @weapon_level #Si le niveau de l'arme trouvée et meilleur que celle équipée, on l'équipe
      @weapon_level = new_weapon
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else #Si elle est du même niveau ou inférieur, on garde celle que l'on a
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  #Méthode pour permettre au joueur de chercher de la vie
  def search_health_pack
    health_pack_num = rand(1..6) #On détermine aléatoirement un nombre pour définir les conséquences
    case health_pack_num
    when 1 #Si il fait 1, le joueur ne trouve rien
      puts "Tu n'as rien trouvé..."
    when 2..5 #Si il fait entre 2 et 4 inclus, le joueur trouve une potion +50pv
      if @life_points > 50 #Le joueur ne pouvant aller au delà de 100pv, si il trouve une potion +50pv alors qu'il a plus de 50pv,...
        @life_points = 100 #... on le maximise à 100pv
      else
        @life_points += 50
      end
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    when 6 #Si il fait au dessus de 5 inclus, le joueur trouve une potion +80pv
      if @life_points > 20 #Pareil que pour +50pv
        @life_points = 100
      else
        @life_points += 80
      end
      puts "Bravo, tu as trouvé un pack de +80 points de vie !"
    end
  end
end