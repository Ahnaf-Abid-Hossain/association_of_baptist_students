class PrayerRequestsController < ApplicationController
  before_action :set_prayer_request, only: %i[show edit update destroy]
  before_action :check_approval_status

  # GET /prayer_requests or /prayer_requests.json
  def index
    @prayer_requests = if current_user.is_admin?
                         PrayerRequest.all
                       else
                         # current_user.user.prayer_requests?
                         current_user.prayer_requests
                       end
  end

  # GET /prayer_requests/1 or /prayer_requests/1.json
  def show
    prayer_request_id = params[:id]
    if !current_user.is_admin? && PrayerRequest.find(prayer_request_id).user_id != current_user.id
      redirect_to(prayer_requests_path, alert: 'You are not authorized to perform this action. LOL')
    end
  end

  # GET /prayer_requests/new
  def new
    @prayer_request = PrayerRequest.new
  end

  # GET /prayer_requests/1/edit
  def edit
    prayer_request_id = params[:id]
    if !current_user.is_admin? && PrayerRequest.find(prayer_request_id).user_id != current_user.id
      redirect_to(prayer_requests_path, alert: 'You are not authorized to perform this action.')
    end
  end

  # POST /prayer_requests or /prayer_requests.json
  def create
    # current_user.user.prayer_requests?
    @prayer_request = current_user.prayer_requests.build(prayer_request_params)
    @prayer_request.status = 'not_read' unless current_user.is_admin?

    respond_to do |format|
      if @prayer_request.save
        format.html { redirect_to(prayer_request_url(@prayer_request), notice: 'Prayer request was successfully created.') }
        format.json { render(:show, status: :created, location: @prayer_request) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @prayer_request.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /prayer_requests/1 or /prayer_requests/1.json
  def update
    respond_to do |format|
      if (current_user.is_admin? || @prayer_request.user_id == current_user.id) && @prayer_request.update(prayer_request_params)
        format.html { redirect_to(prayer_request_url(@prayer_request), notice: 'Prayer request was successfully updated.') }
        format.json { render(:show, status: :ok, location: @prayer_request) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @prayer_request.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /prayer_requests/1 or /prayer_requests/1.json
  def destroy
    if current_user.is_admin? || @prayer_request.user_id == current_user.id
      @prayer_request.destroy!

      respond_to do |format|
        format.html { redirect_to(prayer_requests_url, notice: 'Prayer request was successfully destroyed.') }
        format.json { head(:no_content) }
      end
    else
      redirect_to(prayer_requests_path, alert: 'You are not authorized to perform this action.')
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
end
