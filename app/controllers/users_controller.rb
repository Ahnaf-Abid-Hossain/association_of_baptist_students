class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :force_new_user, only: %i[ index show edit ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @meeting_notes = @user.meeting_note
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    #@user.user = current_user

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "user was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "user was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "user was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  
  def temp_search
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @results = User.all

    if @first_name.present? || @last_name.present?
      @results = User.where("user_first_name ILIKE ? AND user_last_name ILIKE ?", "%#{@first_name}%", "%#{@last_name}%")
    else
      @results = []
    end
    render 'search'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:user_first_name, :user_last_name, :user_email, :user_ph_num, :user_class_year, :user_job_field, :user_location, :user_status, :user_major)
    end

    # Used to direct user to create new user, if needed
    private
    def force_new_user
      if current_user == nil
        # Redirect to new page
        redirect_to new_user_path
      end
    end
end

