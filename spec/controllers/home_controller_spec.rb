require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  fixture_path = 'spec/fixtures/cats.png'
  fixture_extension = 'png'

  describe "POST #transform" do
    it "returns a file" do
      params = { transform: { file: Rack::Test::UploadedFile.new(fixture_path, 'image/png', true),
                              transformations: '-rotate 90 -negate' } }
      post :transform, params: params
      expect(response).to have_http_status(:success)
      expect(response.body.length).to be >= IO.binread(fixture_path).length / 2
      expect(response.header.to_s).to match(fixture_extension)
    end

    context 'with invalid input' do
      it 'returns error' do
        params = { transform: { file: 111,
                                transformations: '-rotate 90 -negate' } }
        post :transform, params: params
        expect(response).to have_http_status(500)
      end
    end
  end
end
