require 'rails_helper'
require 'digest/md5'

describe ImageTransformService do
  input_path = 'spec/fixtures/cats.png'
  output_path = 'spec/fixtures/cats_transformed.png'

  it 'consistently transforms an image' do
    transform_command = '-rotate 90 -negate'
    transformed = ImageTransformService.new(input_path, transform_command).call
    transformed_hash = Digest::MD5.file(transformed.path).hexdigest
    fixture_hash = Digest::MD5.file(output_path).hexdigest
    expect(transformed_hash).to eq fixture_hash
  end

  it 'fails on unsupported imagemagick arguments' do
    invalid_command = '-fail 11'
    expect { ImageTransformService.new(input_path, invalid_command).call }.to raise_error(MiniMagick::Error)
  end

  describe 'potentional vulnerabilities' do
    it 'raises error on attempts to pass extra bash code' do
      hacky_strings = ["-rotate 90 && echo hello", "-rotate 90 ; echo hello"]
      hacky_strings.each do |str|
        expect { ImageTransformService.new(input_path, str).call }.to raise_error(MiniMagick::Error)
      end
    end
  end
end
