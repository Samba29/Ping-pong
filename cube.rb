/ This script contain a definition of Cube/

#Créer les spécifités de chaque type de cube.
#Créer les malus\bonus de vitesse si possible
require_relative("ui_object.rb")

class Cube < UI_object
	attr_reader :m_type
	def initialize(size_x, size_y, type = CUBE::Normal ,coordonne = Coordonne::new(), image = nil)
		coordonne.m_z = ZOrder::CUBE
		@m_type = type
		if type == CUBE::Normal
			image = Image::CubeStandard
		elsif type == CUBE::Acceleration
			image = Image::CubeAcc
		elsif type == CUBE::Fix
			image = Image::CubeFix
		else
			image = Image::CubeDecc
		end	
		super image, size_x, size_y, coordonne
	end

	def receive_message_collision(collider)
		super
		/
		if @m_type == CUBE::Acceleration
			collider.currentVelocity = 100
		elsif @m_type == CUBE::Decceleration
			collider.currentVelocity = 100
		end/
		self.destroy
	end
	#Detruit le cube
	def destroy()
		@destruct = true
	end

	def On_collision(collider)
		if super
			if !(@m_type == CUBE::Fix)
				@sound = Gosu::Sample.new(Sound::Bold)
				@sound.play(0.02)
				self.destroy
			end
		end
	end

end