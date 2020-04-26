module Image
	CubeStandard = 'ressources/images/cube.png'
	CubeAcc = "ressources/images/cubeAcc.png"
	CubeDecc = "ressources/images/cubeDecc.png"
	CubeFix = "ressources/images/cubeFix.png"
	Background = "ressources/images/fond.png"
	ScreenX = 1200
	ScreenY = 800
	DOWN = Gosu::KB_DOWN
	UP = Gosu::KB_UP
	BorderY = 0
	BorderX = 400
	ScoreX =  950
	ScoreY =  150
	Border = "ressources/images/score.png"
	Menu = "ressources/images/menu.png"
end

module Players
	Player_image = "ressources/images/barre.png"
	Player2_image = "ressources/images/barre2.png"
	Player_sizeX = 32
	Player_sizeY = 128
	TIMECONTACT = 250
end

module BALL
	AngleB = 225
	AngleA = 45
	Image = "ressources/images/ball.png"
	Velocity = 5
	BonusVelocite = 0.1
	SizeX = 32
	SizeY = 32
end

module CUBE
	Fix, Normal, Acceleration, Decceleration = *(1..4)
	BonusAccecleration = 2
	MalusDecceleration = 2
end

module ZOrder
	PLAYER = 2
	BALL = 1
	CUBE =1
	BACKGROUND = 0 
	PANEL = 2

	end

module Sound
	Background = "ressources/audio/Tetris Type A Theme (Korobeiniki).mp3"
	Play = "ressources/audio/Pac-man theme remix - By Arsenic1987.mp3"
	Bold = "ressources/audio/eclair.mp3"
end
