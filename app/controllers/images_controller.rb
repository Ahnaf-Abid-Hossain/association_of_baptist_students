class ImagesController < ApplicationController
  def new
  end

  def create
    google_drive_service = GoogleDriveService.new

    # Replace these paths and folder_id with actual values
    image_path = params[:file].tempfile.path
    folder_id = '1z6-2YvXxsIaxjK4HnmX5hTkcam-0X-oO'

    google_drive_service.upload_image(image_path, folder_id)

    # Handle the response as needed
  end
end

