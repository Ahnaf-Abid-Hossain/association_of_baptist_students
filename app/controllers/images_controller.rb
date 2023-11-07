class ImagesController < ApplicationController
  def new; end

  def create
    @user = current_user
    google_drive_service = GoogleDriveService.new

    # validation that file is selected when user clicks "Upload Image"
    if params[:file].present?
      image_path = params[:file].tempfile.path
      folder_id = '1z6-2YvXxsIaxjK4HnmX5hTkcam-0X-oO'
      image_url = google_drive_service.upload_image(image_path, folder_id)

      file_extension = File.extname(image_path).downcase

      content_type = case file_extension
                     when '.jpg', '.jpeg'
                       'image/jpeg'
                     when '.png'
                       'image/png'
                     end

      # validation of file type
      if content_type != 'image/png' && content_type != 'image/jpeg'
        flash[:alert] = 'Please choose a valid file type, JPG or PNG.'
        redirect_to(new_image_path)
      elsif image_url
        @user.update!(avatar_url: image_url)
        flash[:success] = 'Success! Your profile picture has been updated.'
        redirect_to(@user)
        # Store the image URL in the user's profile
      end
    else
      flash[:alert] = 'Please choose an image to upload.'
      redirect_to(new_image_path)
    end
  end
end
