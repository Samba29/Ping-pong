/This script manage a scene where the game will take place/

#Regler l'affichage des scores. (fait)
#Etablir la postion definitive des scores(faut)
#Fuxer les types de cubes (jouer avec les vitesses) (fait)
#Defunur l'affichage des ecrans (fait)
#Realiser les anumations 
#Realiser une scène test(fait)
#Mettre les chemins en mode relatif dans les modules(fait)
#Créer un éditeur de niveau par fichier
#Verifier l'abscence de numéro magique
#libérez l'espace à la sortie de la scène
require 'gosu'
require_relative 'ui_object.rb'
require_relative "mod_images_manager.rb"
require_relative "player.rb"
require_relative 'ball.rb'
require_relative "cube.rb"
require 'date'
class Scene < Gosu::Window
  def initialize(arrayCube = nil, time = 60, difficultie = 1, sound = Sound::Play)
    super Image::ScreenX, Image::ScreenY
    @difficultie = difficultie
    @background_sound = Gosu::Song.new(sound)
    @lifetime = Time.now + time

	@background_image = Gosu::Image.new(Image::Background, :tileable => false)
	@border_image = Gosu::Image.new(Image::Border, :tileable => false)
	@player = Player.new(Players::Player_image, Players::Player_sizeX, Players::Player_sizeY)
	@ball = Ball.new(Coordonne::new(Image::ScreenX/2 - Image::BorderX/2 - 32/2 ,Image::ScreenY/2 - Image::BorderY/2 - 32/2 ,0))
	@player2 = Player.new(Players::Player2_image, Players::Player_sizeX, Players::Player_sizeY, Coordonne::new(Image::ScreenX - Players::Player_sizeX - Image::BorderX,0 ,0))
	@font = Gosu::Font.new(40)
	@items = [@player,@ball, @player2]
	
	@game_over = false
	@timeLeft = @lifetime
	@win = false
	if arrayCube == nil
		@nbCube = 5
		self.randomCube(CUBE::Fix, 5)
		self.randomCube(CUBE::Normal, 3)
		self.randomCube(CUBE::Acceleration, 5)
		self.randomCube(CUBE::Decceleration, 2)
	else
		self.loadCube(arrayCube)
	end
	@background_sound.play(true)
	@time = 0
  end

  def Search_collision
  	@items.each{|e| if e.destruct == true 
  		@items.delete e 
  	end}
  	i = @items.length
  	k = 0
  	while k < i
  		m = @items[k+1...i]
  		m.each{|e| e.On_collision(@items[k])}
  		k+=1
  	end
  end

  def draw_items
  	@items.each{|e| e.draw}
  end

  def update
  	if !@game_over and !@win
	  	@player.Player_update
	    @player2.Player_update
	    @ball.ball_update
	    self.Search_collision()
	    @game_over =  @ball.game_over?
	    @win = ((@lifetime - Time.now )<= 0)
	 
	 else
	 	sleep 2.0
	 	self.close
	 	load("D:/Dd/CODE/ruby/gosu/main.rb", true)
	 end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @border_image.draw(Image::ScreenX - Image::BorderX, 0, ZOrder::PANEL)
    @font.draw_text("Score: #{@player.score + @player2.score}", Image::ScoreX, Image::ScoreY, ZOrder::PANEL, 1.0, 1.0, Gosu::Color::YELLOW)
    @font.draw_text("Temps restant: #{(@lifetime - Time.now ).to_i}", Image::ScoreX, Image::ScoreY + 200, ZOrder::PANEL, 0.5, 1.0, Gosu::Color::YELLOW)
    self.draw_items
    if @game_over 
    	@font.draw_text("Game Over", (Image::ScreenX - Image::BorderX)/2 - 100, Image::ScreenY/2, ZOrder::PANEL, 1.0, 1.0, Gosu::Color::YELLOW)
    end
    if @win
    	@font.draw_text("You win", (Image::ScreenX - Image::BorderX)/2 - 50, Image::ScreenY/2, ZOrder::PANEL, 1.0, 1.0, Gosu::Color::YELLOW)
    end
  end

  def randomCube(type, nombre)
  	@posX = (Image::ScreenX - Image::BorderX)/32
  	@posY = (Image::ScreenY)/32
  	@i = 0
  	while @i < nombre
  		ncubex = rand(5..20)
  		ncubey =  rand(5..20)
  		@items.push Cube.new(32,32, type, Coordonne.new(ncubex*32,ncubey*32 ,ZOrder::CUBE))
  		@i+=1
  	end
  end 

  def loadCube(arrayCube)
  	arrayCube.each{|cube| @items.push Cube.new(32,32, cube[2].to_i, Coordonne.new(cube[0].to_i*32,cube[1].to_i*32 ,ZOrder::CUBE))}
  end

  def reset
	@items = [@player,@ball, @player2]
	@lifetime = 60
	@game_over = false
	@timeLeft = @lifetime
	@win = false
	@nbCube = 5
	self.randomCube(CUBE::Fix, 5)
	self.randomCube(CUBE::Normal, 3)
	self.randomCube(CUBE::Acceleration, 5)
	self.randomCube(CUBE::Decceleration, 2)
	@background_sound = Gosu::Song.new(Sound::Play)
	@background_sound.volume = 0.05
	@background_sound.play(true)
	@time = 0
	@lifetime += Gosu::milliseconds/1000
  end
end

#a = Scene.new
#a.show
#a.reset
#


