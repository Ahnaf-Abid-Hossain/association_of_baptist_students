class ImagesController < ApplicationController
  def new
  end

  def create
    @user = current_user

    google_drive_service = GoogleDriveService.new

    # Location to put it in
    image_path = params[:file].tempfile.path
    folder_id = '1z6-2YvXxsIaxjK4HnmX5hTkcam-0X-oO'

    image_url = google_drive_service.upload_image(image_path, folder_id)

    

    if image_url
      # Store the image URL in the user's profile
      @user.update(avatar_url: image_url)
    else
      # Handle the error case
    end
  end
end

