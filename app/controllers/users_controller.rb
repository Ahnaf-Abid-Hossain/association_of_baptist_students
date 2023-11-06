class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :force_new_user, only: %i[index show edit]
  before_action :check_approval_status, except: %i[edit update]
  before_action :authorize_user, only: %i[edit update destroy]

  def approve
    @alumni = User.find(params[:id])
    @alumni.update!(approval_status: 1)
    redirect_to(users_path, notice: 'Alumni approved successfully.')
  end

  def decline
    @alumni = User.find(params[:id])
    @alumni.update!(approval_status: -1)
    redirect_to(users_path, notice: 'Alumni declined successfully.')
  end

  def approve_admin
    @alumni = User.find(params[:id])
    @alumni.update(is_admin: 1)
    redirect_to(users_path, notice: 'Alumni made Admin successfully')
  end

  # Make sure user is authorized to access account
  def authorize_user
    user = User.find(params[:id])
    unless current_user == user || current_user.is_admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
  

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @meeting_notes = @user.meeting_note
    # if current_user.approval_status != 1
    # redirect_to(prayer_requests_path, alert: 'You are not authorized to perform this action. Please wait for an admin to approve you.')
    # end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    # @user.user = current_user
    # @user.approval_status = 3
    respond_to do |format|
      if @user.save
        format.html { redirect_to(user_url(@user), notice: 'user was successfully created.') }
        format.json { render(:show, status: :created, location: @user) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to(user_url(@user), notice: 'user was successfully updated.') }
        format.json { render(:show, status: :ok, location: @user) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    if current_user == @user || current_user.is_admin?
      @user.destroy!
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_url, alert: 'You are not authorized to delete this user.' }
        format.json { render json: { error: 'Unauthorized' }, status: :unauthorized }
      end
    end
  end

  def privacy_settings
    @user = User.find(params[:id])
    # You can add code here to handle displaying and updating privacy settings
  end

  def basic_search
    @search_name = params[:search_name]
    @first_name = nil
    @last_name = nil

    if @search_name.present?
      if @search_name.include?(' ')
        @first_name, @last_name = @search_name.split(' ', 2)
      else
        @first_name = @last_name = @search_name
      end
    end

    @results = if @search_name.present?
                 if @search_name.include?(' ')
                   User.where('user_first_name ILIKE ? AND user_last_name ILIKE ? AND approval_status = 1', "%#{@first_name}%", "%#{@last_name}%")
                 else
                   User.where('user_first_name ILIKE ? OR user_last_name ILIKE ? AND approval_status = 1', "%#{@first_name}%", "%#{@last_name}%")
                 end
               else
                 []
               end
  end

  def temp_search
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @class_year = params[:class_year]
    @major = params[:major]
    @current_city = params[:current_city]
    @results = User.all

    @results = if @first_name.present? || @last_name.present? || @class_year.present? || @major.present? || @current_city.present?
                 
                 if @class_year.present?
                   User.where(
                     'user_first_name ILIKE ? AND user_last_name ILIKE ? AND user_class_year = ? AND is_class_year_private = False AND user_major ILIKE ? AND is_major_private = False AND user_location ILIKE ? AND is_location_private = False AND approval_status = 1', "%#{@first_name}%", "%#{@last_name}%", Integer(@class_year, 10), "%#{@major}%", "%#{@current_city}%"
                   )
                 else
                   User.where(
                     'user_first_name ILIKE ? AND user_last_name ILIKE ? AND user_major ILIKE ? AND is_major_private = False AND user_location ILIKE ? AND is_location_private = False AND approval_status = 1', "%#{@first_name}%", "%#{@last_name}%", "%#{@major}%", "%#{@current_city}%"
                   )
                 end
               else
                 []
               end
    render('search')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:user_first_name,
                                 :user_last_name,
                                 :user_contact_email,
                                 :user_ph_num,
                                 :user_class_year,
                                 :user_job_field,
                                 :user_location,
                                 :user_status,
                                 :user_major,
                                 :is_contact_email_private,
                                 :is_ph_num_private,
                                 :is_class_year_private,
                                 :is_job_field_private,
                                 :is_location_private,
                                 :is_status_private,
                                 :is_major_private,
                                 :approval_status
                                )
  end

  # Used to direct user to create new user, if needed

  def force_new_user
    if current_user.user_first_name.nil? && !params[:controller].start_with?('users/') && !params[:action].eql?('edit')
      # Redirect to new page
      redirect_to(edit_user_path(current_user))
    end
  end
end
