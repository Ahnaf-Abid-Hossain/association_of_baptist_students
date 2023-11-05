class ImagesController < ApplicationController
  def new
  end

  def create
    google_drive_service = GoogleDriveService.new

    # Replace these paths and folder_id with actual values
    image_path = 'path_to_uploaded_image.jpg'
    folder_id = '1z62YvXxsIaxjK4HnmX5hTkcam0XoO'

    google_drive_service.upload_image(image_path, folder_id)

    # Handle the response as needed
  end
end

