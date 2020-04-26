#this script contain a script in charge to manage load and or save map ub the game

require_relative('scene.rb')
class SaveLoad

	def initialize
	end


	def load(folderName)
		#...
		#...
		result = []
		i = 0
		File.foreach("ressources/map/#{folderName}") { |line| result  += [line.split(' ')] }
		#print result
		return a = Scene.new(result[1...result.length], result[0][0].to_i).show#the must be return a scene
	end

	def pre_load(folderName)
		result = []
		File.foreach("ressources/map/#{folderName}") { |line| result  += [line.split(' ')] }
		return result[0][0]
	end

	def save(folderName)
		#...
		#...
	end

	def ChooseMap
		maps = Dir.children("ressources/map")
		interval = (0...maps.length)
		map = rand interval
		load(maps[map])
	end


end
#SaveLoad.new.load("map2.pik")