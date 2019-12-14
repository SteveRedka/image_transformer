class HomeController < ApplicationController
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
end
