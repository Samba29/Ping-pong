# This class contain a script for ball
require_relative "ui_object.rb"

#Verifier lescalculs de collision(fait)
class Ball < UI_object
# Créer un rebondissement spéciale pour les barres de joueurs(fait)
  attr_writer :currentVelocity
	def initialize(coordonne = Coordonne::new(), angle = 45, image = BALL::Image, size_x = BALL::SizeX, size_y = BALL::SizeY)
    coordonne.m_z = ZOrder::BALL
		super image, size_x, size_y, coordonne
		@m_velocityX = 0.0
		@m_velocityY = 0.0
		@m_angle = angle
    @currentVelocity = BALL::Velocity
    @font = Gosu::Font.new(40)
	end

	def change_direction(collider)
    # important, c'est la balle que lon considère a droite ou a gauche...
    @left = @right = @up = @down = false
    @dx = @dy = @mx = @my = 0
    if collider.class != Player #si ce n'est pas un joueur
      if collider.m_coordonne.m_x + collider.m_size_x >= self.m_coordonne.m_x 
      #and (!(self.m_coordonne.m_y + self.m_size_y >= collider.m_size_y) or !(collider.m_coordonne.m_y + collider.m_size_y >= self.m_coordonne.m_y)) #balle a droite
        @right = true;
      elsif self.m_coordonne.m_x + self.m_size_x >= collider.m_coordonne.m_x #and (!(self.m_coordonne.m_y + self.m_size_y >= collider.m_size_y) or !(collider.m_coordonne.m_y + collider.m_size_y >= self.m_coordonne.m_y))#balle a gauche
        @left = true;
      elsif self.m_coordonne.m_y + self.m_size_y >= collider.m_size_y #balle en haut
        @up = true;
      elsif collider.m_coordonne.m_y + collider.m_size_y >= self.m_coordonne.m_y #balle en bas
        @down = true
      end
    else
      #si c'est une barre, on inverse la direction
      @left = true
    end

    if @left or @right
      @m_angle *= -1
    elsif @up
      @m_angle = @m_angle == 135? 45: -45
    elsif @down
      @m_angle = @m_angle == 45? 135: -135
    end

  end


	def accelerate
		@m_velocityX += Gosu.offset_x(@m_angle, @currentVelocity)
    @m_velocityY += Gosu.offset_y(@m_angle, @currentVelocity)
	end
	def move
		self.On_Board_Collision
		self.accelerate
	    self.m_coordonne.m_x += @m_velocityX 
	    self.m_coordonne.m_y += @m_velocityY
	    # on remet la vitesse a 0 pour obtenir un freinage brusque
	    @m_velocityX = 0
	    @m_velocityY = 0
  end
  # R2ECRIRE LES FONCTIONS DE CHANGEMENT DANGLE en s'inspirant de celle de change_direction
  def On_Board_Collision
  	if Gosu::milliseconds > @previous_contact + Players::TIMECONTACT 
  		if self.m_coordonne.m_y < 0 #Haut de l'écran
       @m_angle = @m_angle == 45? 135: -135
  		end
  		if self.m_coordonne.m_y + self.m_size_y > Image::ScreenY - Image::BorderY # Bas de l'écran
        @m_angle = @m_angle == 135? 45: -45
  		end
  	end
  end
  #Ne pas oublier de placer le reste du contenu de collision dans une classe plus adaptée
  #Recalculer les valeurs des angles
  	def On_collision(collider)
  		if super
        self.receive_message_collision(collider)
  		end
  	end

  	def ball_update
		  self.move
  	end

  	def draw
  		super
      #@font.draw_text("velocity #{@currentVelocity}", 10,10, 1.0, 1.0, 1.0, Gosu::Color::YELLOW)
  	end

    def receive_message_collision(collider)
      super
      if collider.class == Cube
        if collider.m_type == CUBE::Acceleration
          @currentVelocity += CUBE::BonusAccecleration
        elsif collider.m_type == CUBE::Decceleration and @currentVelocity - CUBE::MalusDecceleration >= 1 
          @currentVelocity -= CUBE::MalusDecceleration
        end
      end
      self.change_direction(collider)
    end

    def game_over?
      if self.m_coordonne.m_x > Image::ScreenX - Image::BorderX or (self.m_coordonne.m_x +  self.m_size_x <= 0)#Fond de l'écran
        return true
      end
    end
end