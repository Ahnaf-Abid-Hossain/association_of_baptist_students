require 'google/apis/drive_v3'
require 'googleauth'


class GoogleDriveService
  def initialize
    @drive_service = Google::Apis::DriveV3::DriveService.new
    authorize_service_account
  end

  def upload_image(image_path, folder_id)
    file_metadata = Google::Apis::DriveV3::File.new(name: File.basename(image_path), parents: [folder_id])
    media = Google::Apis::DriveV3::Media::UploadIO.new(image_path, 'image/jpeg')

    begin
      @drive_service.create_file(file_metadata, media_type: 'image/jpeg', media: media)
    rescue Google::Apis::ClientError => e
      # Handle any errors
      Rails.logger.error("Google Drive upload error: #{e.message}")
    end
  end

  private

  def authorize_service_account
    client_id = Google::Auth::ClientId.new(ENV['GOOGLE_DRIVE_CLIENT_ID'], ENV['GOOGLE_DRIVE_CLIENT_SECRET'])
    # client_id.client_id = ENV['GOOGLE_DRIVE_CLIENT_ID']
    # client_id.client_secret = ENV['GOOGLE_DRIVE_CLIENT_SECRET']
    Rails.logger.info("GOOGLE_DRIVE_CLIENT_SECRET: #{ENV['GOOGLE_DRIVE_CLIENT_SECRET']}")
    Rails.logger.info("GOOGLE_DRIVE_CLIENT_CREDENTIALS: #{ENV['GOOGLE_DRIVE_CLIENT_CREDENTIALS']}")
    json_key = JSON.parse(ENV['GOOGLE_DRIVE_CLIENT_CREDENTIALS'])

    credentials = Google::Auth::ServiceAccountCredentials.make_creds(
      # json_key_io: File.open('path/to/your/service_account_credentials.json'),
      json_key_io: StringIO.new(json_key.to_json), # Use StringIO to treat the JSON as a file-like object
      scope: ['https://www.googleapis.com/auth/drive'],
      client_id: client_id,
      client_email: 'AssocBaptStuDrive@gmail.com'
    )

    @drive_service.authorization = credentials
  end
end
