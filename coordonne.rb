
require_relative "mod_images_manager.rb"
class Coordonne
	attr_reader :m_x, :m_y, :m_z
	attr_writer :m_x, :m_y, :m_z

	def initialize(x = 0,y = 0,z = 0)
		@m_x = x
		@m_y = y
		@m_z = z
		@m_x %= Image::ScreenX - Image::BorderX
		@m_y %= Image::ScreenY - Image::BorderY
	end

end 