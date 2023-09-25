class PrayerRequestsController < ApplicationController
  before_action :set_prayer_request, only: %i[ show edit update destroy ]

  # GET /prayer_requests or /prayer_requests.json
  def index
    if current_user.is_admin?
      @prayer_requests = PrayerRequest.all
    else
      @prayer_requests = current_user.alumni.prayer_requests
    end
  end

  # GET /prayer_requests/1 or /prayer_requests/1.json
  def show
    authorize_prayer_request(@prayer_request)
  end

  # GET /prayer_requests/new
  def new
    @prayer_request = PrayerRequest.new
  end

  # GET /prayer_requests/1/edit
  def edit
    authorize_prayer_request(@prayer_request)
  end

  # POST /prayer_requests or /prayer_requests.json
  def create
    @prayer_request = current_user.alumni.prayer_requests.build(prayer_request_params)
    if !current_user.is_admin?
      @prayer_request.status = "not_read"
    end

    respond_to do |format|
      if @prayer_request.save
        format.html { redirect_to prayer_request_url(@prayer_request), notice: "Prayer request was successfully created." }
        format.json { render :show, status: :created, location: @prayer_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prayer_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prayer_requests/1 or /prayer_requests/1.json
  def update
    authorize_prayer_request(@prayer_request)
    respond_to do |format|
      if @prayer_request.update(prayer_request_params)
        format.html { redirect_to prayer_request_url(@prayer_request), notice: "Prayer request was successfully updated." }
        format.json { render :show, status: :ok, location: @prayer_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prayer_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prayer_requests/1 or /prayer_requests/1.json
  def destroy
    authorize_prayer_request(@prayer_request)
    @prayer_request.destroy

    respond_to do |format|
      format.html { redirect_to prayer_requests_url, notice: "Prayer request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prayer_request
      @prayer_request = PrayerRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prayer_request_params
      if current_user.is_admin?
        params.require(:prayer_request).permit(:request, :status)
      else
        params.require(:prayer_request).permit(:request)
      end
    end

    def authorize_prayer_request(prayer_request)
      return if current_user.is_admin?

      unless prayer_request.alumni.user_id == current_user.id
        redirect_to prayer_requests_path, alert: 'You are not authorized to perform this action.'
      end
    end
end
