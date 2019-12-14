class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :validate_params

  def transform
    uploaded_file = transform_params[:file]
    transformed_file = ImageTransformService.new(uploaded_file.path,
                                                 transform_params[:transformations]).call
    send_file(transformed_file.path, type: 'mime/type')
  end

  private

  def transform_params
    params.require(:transform).permit(:file, :transformations)
  end

  def validate_params
    uploaded_file = transform_params[:file]
    unless uploaded_file.class == ActionDispatch::Http::UploadedFile
      render_500({ error: 'this is not a file' })
    end
  end

  def render_500(e = { error: '500 Internal Server Error' })
    render json: e, :status => 500, :layout => false
  end
end
