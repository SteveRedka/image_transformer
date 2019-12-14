require 'mini_magick'

class ImageTransformService
  def initialize(input_path, params = '')
    @input_path = input_path
    @params = params.split(' ')
    @image = MiniMagick::Image.open(@input_path).dup
  end

  def call
    MiniMagick::Tool::Convert.new do |convert|
      convert << @input_path
      convert.merge! @params
      convert << @image.path
    end
    @image
  end
end
