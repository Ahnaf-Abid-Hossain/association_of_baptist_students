class PrayerRequestsController < ApplicationController
  before_action :set_prayer_request, only: %i[ show edit update destroy ]

  # GET /prayer_requests or /prayer_requests.json
  def index
    @prayer_requests = PrayerRequest.all
  end

  # GET /prayer_requests/1 or /prayer_requests/1.json
  def show
  end

  # GET /prayer_requests/new
  def new
    @prayer_request = PrayerRequest.new
  end

  # GET /prayer_requests/1/edit
  def edit
  end

  # POST /prayer_requests or /prayer_requests.json
  def create
    @prayer_request = PrayerRequest.new(prayer_request_params)

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
      params.require(:prayer_request).permit(:request, :status, :alumni_id)
    end
end
