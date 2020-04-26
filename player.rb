/This script contain a definition of the player class/
require_relative "ui_object.rb"


class Player < UI_object

  attr_reader :previous_contact, :score
	def initialize(image, size_x, size_y, coordonne = Coordonne::new())
    coordonne.m_z = ZOrder::PLAYER
		super image, size_x, size_y, coordonne
		@m_velocity = 0.0
		@score = 0
		@beep = Gosu::Sample.new("D:/Dd/CODE/ruby/gosu/ressources/audio/beep.wav")
	end
  def get_score
    return @score
  end
	def move
    @m_coordonne.m_y += @m_velocity
    @m_velocity *= 0.95
  end

  def Go_down
  		@m_velocity += Gosu.offset_y(0.0, -0.5)
  	end

  	def Go_up
  		@m_velocity += Gosu.offset_y(0.0, 0.5)
  	end

  	def Player_update
  		if Gosu.button_down? Image::UP
  			self.Go_up()
  		end
  		if Gosu.button_down? Image::DOWN
  			self.Go_down()
  		end
  		self.move
      if @m_coordonne.m_y  < 0 # Si la barre est trop haute
          @m_coordonne.m_y = 10
          @m_velocity = 0
        end
      if @m_coordonne.m_y + Players::Player_sizeY > Image::ScreenY - Image::BorderY
          @m_coordonne.m_y = Image::ScreenY  - Image::BorderY - Players::Player_sizeY
      end 
  	end


    #Ne pas oublier de placer le reste du contenu de collision dans une classe plus adaptée
  	def On_collision(collider)
      if super
        self.receive_message_collision(collider)
      end
  	end

  	def draw
  		super
  	end

    def  receive_message_collision(collider) 
      super
      @beep.play
      @score+=10
    end
end

