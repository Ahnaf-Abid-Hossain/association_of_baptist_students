require 'google/apis/drive_v3'
require 'googleauth'

class GoogleDriveService
  def initialize
    @drive_service = Google::Apis::DriveV3::DriveService.new
    authorize_service_account
  end

  def upload_image(image_path, folder_id)
    file_metadata = Google::Apis::DriveV3::File.new(
      name: File.basename(image_path),
      parents: [folder_id]
    )
    file_extension = File.extname(image_path).downcase

    content_type = case file_extension
                   when '.jpg', '.jpeg'
                     'image/jpeg'
                   when '.png'
                     'image/png'
                   end

    begin
      uploaded_file = @drive_service.create_file(file_metadata, upload_source: image_path, content_type: content_type)

      # make uploaded images accesible by application for profile picture
      @drive_service.create_permission(
        uploaded_file.id,
        Google::Apis::DriveV3::Permission.new(
          type: 'anyone',
          role: 'reader'
        ),
        fields: 'id'
      )

      "https://drive.google.com/uc?id=#{uploaded_file.id}"
    rescue Google::Apis::ClientError => e
      # Handle any errors
      Rails.logger.error("Google Drive upload error: #{e.message}")
    end
  end

  private

  def authorize_service_account
    client_id = Google::Auth::ClientId.new(ENV.fetch('GOOGLE_DRIVE_CLIENT_ID', nil), ENV.fetch('GOOGLE_DRIVE_CLIENT_SECRET', nil))
    Rails.logger.info("GOOGLE_DRIVE_CLIENT_SECRET: #{ENV.fetch('GOOGLE_DRIVE_CLIENT_SECRET', nil)}")
    Rails.logger.info("GOOGLE_DRIVE_CLIENT_CREDENTIALS: #{ENV.fetch('GOOGLE_DRIVE_CLIENT_CREDENTIALS', nil)}")
    json_key = JSON.parse(ENV.fetch('GOOGLE_DRIVE_CLIENT_CREDENTIALS', nil))

    credentials = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: StringIO.new(json_key.to_json), # Use StringIO to treat the JSON as a file-like object
      scope: ['https://www.googleapis.com/auth/drive'],
      client_id: client_id,
      client_email: 'AssocBaptStuDrive@gmail.com'
    )

    @drive_service.authorization = credentials
  end
end
