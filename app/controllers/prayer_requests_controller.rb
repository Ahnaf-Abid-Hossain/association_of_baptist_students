class PrayerRequestsController < ApplicationController
  before_action :set_prayer_request, only: %i[show edit update destroy]
  before_action :check_approval_status

  # GET /prayer_requests or /prayer_requests.json
  def index
    @user_prayer_requests =
      current_user.prayer_requests.order(created_at: :desc)

    @public_prayer_requests = if current_user.is_admin?
                                PrayerRequest.order(created_at: :desc)
                              else
                                PrayerRequest.where(is_public: true).order(created_at: :desc)
                              end
  end

  # GET /prayer_requests/1 or /prayer_requests/1.json
  def show
    prayer_request_id = params[:id]
    if !current_user.is_admin? && !PrayerRequest.find(prayer_request_id).is_public && PrayerRequest.find(prayer_request_id).user_id != current_user.id
      redirect_to(prayer_requests_path, alert: 'You are not authorized to perform this action.')
    end
    if current_user.is_admin?
      prayer_request = PrayerRequest.where(id: prayer_request_id)[0]
      prayer_request.update!(status: 'Read') if prayer_request.status == 'Not Read'
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
    @prayer_request = current_user.prayer_requests.build(create_prayer_request_params)
    @prayer_request.status = 'Not Read'

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
      if update_prayer_request
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

  def help; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_prayer_request
    @prayer_request = PrayerRequest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def create_prayer_request_params
    params.require(:prayer_request).permit(:request, :is_anonymous, :is_public)
  end

  def update_prayer_request
    permitted_params = case
                       when admin_with_other_user?
                         params.require(:prayer_request).permit(:status)
                       when admin_with_own_request?
                         params.require(:prayer_request).permit(:request, :status, :is_anonymous, :is_public)
                       when user_with_own_request?
                         params.require(:prayer_request).permit(:request, :is_anonymous, :is_public)
                       when user_with_other_user?
                         return false
                       end

    return @prayer_request.update(permitted_params)
  end

  def admin_with_other_user?
    current_user.is_admin? && @prayer_request.user_id != current_user.id
  end

  def admin_with_own_request?
    current_user.is_admin? && @prayer_request.user_id == current_user.id
  end

  def user_with_own_request?
    @prayer_request.user_id == current_user.id
  end

  def user_with_other_user?
    @prayer_request.user_id != current_user.id
  end
end
