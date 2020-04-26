/ this script contain a main loop of the game/

#Faire lezs boutons
require 'gosu'
require_relative "mod_images_manager.rb"
require_relative 'scene.rb'
require_relative 'save_load.rb'

class Menu < Gosu::Window
	def initialize
		super Image::ScreenX, Image::ScreenY
		@background_image = Gosu::Image.new(File.absolute_path(Image::Menu), :tileable => true)
		@font = Gosu::Font.new(40)
		@background_sound = Gosu::Song.new(Sound::Background)
		@background_sound.play(true)
	end

	def update
		if Gosu.button_down? Gosu::KB_NUMPAD_1 
			@background_sound.stop
			 if rand(0..1) == 0 
			 	a = Scene.new.show 
			 else 
			 	a = SaveLoad.new.ChooseMap 
			 end
		elsif Gosu.button_down? Gosu::KB_NUMPAD_2 
			self.close
			exit
		end
	end

	def draw
		@background_image.draw(0,0,ZOrder::PANEL)
		@font.draw_text("1 .Nouvelle partie",160, 500, ZOrder::PANEL, 1.0, 1.0, Gosu::Color::YELLOW)
		@font.draw_text("2 .Exit",160, 600, ZOrder::PANEL, 1.0, 1.0, Gosu::Color::YELLOW)
	end
end
Menu.new.show