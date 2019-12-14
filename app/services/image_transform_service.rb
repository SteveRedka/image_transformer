require 'mini_magick'

class ImageTransformService
  def initialize(input_path, transformations = '')
    @input_path = input_path
    @transformations = transformations.split(' ')
    @image = MiniMagick::Image.open(@input_path).dup
  end

  def call
    MiniMagick::Tool::Convert.new do |convert|
      convert << @input_path
      convert.merge! @transformations
      convert << @image.path
    end
    @image
  end
end
