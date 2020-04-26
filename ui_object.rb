/ This script provide a definition of UIObject which is the basic class for somes ithers class in the games like okayer, ball, cube.../
require 'gosu'
require_relative 'coordonne.rb'
class UI_object
	attr_reader :m_image, :m_coordonne, :m_size_x, :m_size_y, :destruct 
	def initialize(image, size_x, size_y, coordonne = Coordonne::new())
		@m_image = Gosu::Image.new(image, :tileable => false)
		@m_coordonne = coordonne if coordonne.is_a?(Coordonne)
		@m_size_x = size_x
		@m_size_y = size_y
		@m_angle = 0.0;
		@previous_contact = -100000.0
		@destruct = false # c'est une variable pour s'assurer que les cubes puissent être detruits
	end

	def update
	end

	def draw
		@m_image.draw(@m_coordonne.m_x, @m_coordonne.m_y, @m_coordonne.m_z)
	end

  	def On_collision(collider)
  		if Gosu::milliseconds > @previous_contact + Players::TIMECONTACT
  			if ((collider.m_coordonne.m_x >= self.m_coordonne.m_x + self.m_size_x) or (self.m_coordonne.m_x >= collider.m_coordonne.m_x + collider.m_size_x) or 
  				(collider.m_coordonne.m_y >= self.m_coordonne.m_y + self.m_size_y) or (self.m_coordonne.m_y >= collider.m_coordonne.m_y + collider.m_size_y))
  			return false
  			end
  			@previous_contact = Gosu::milliseconds
  			collider.receive_message_collision(self)
  			return true
  		end
  	end
  	def  receive_message_collision(collider) 
  		@previous_contact = Gosu::milliseconds
  	end


end