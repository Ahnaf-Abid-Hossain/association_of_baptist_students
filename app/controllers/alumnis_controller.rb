class AlumnisController < ApplicationController
  before_action :set_alumni, only: %i[ show edit update destroy ]
  before_action :force_new_alumni, only: %i[ index show edit ]

  # GET /alumnis or /alumnis.json
  def index
    @alumnis = Alumni.all
  end

  # GET /alumnis/1 or /alumnis/1.json
  def show
  end

  # GET /alumnis/new
  def new
    @alumni = Alumni.new
  end

  # GET /alumnis/1/edit
  def edit
  end

  # POST /alumnis or /alumnis.json
  def create
    # @alumni = Alumni.new(alumni_params)

    # For testing
    @alumni = Alumni.new(alum_first_name: "Test",
      alum_last_name: "User",
      alum_email: "test@gmail.com",
      alum_ph_num: "(555) 555-5555",
      alum_class_year: 2024,
      alum_job_field: "Software Engineering",
      alum_location: "Houston, TX",
      alum_status: "Current Student",
      alum_major: "Computer Science")
    @alumni.user = current_user

    respond_to do |format|
      if @alumni.save
        format.html { redirect_to alumni_url(@alumni), notice: "Alumni was successfully created." }
        format.json { render :show, status: :created, location: @alumni }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @alumni.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alumnis/1 or /alumnis/1.json
  def update
    respond_to do |format|
      if @alumni.update(alumni_params)
        format.html { redirect_to alumni_url(@alumni), notice: "Alumni was successfully updated." }
        format.json { render :show, status: :ok, location: @alumni }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @alumni.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumnis/1 or /alumnis/1.json
  def destroy
    @alumni.destroy

    respond_to do |format|
      format.html { redirect_to alumnis_url, notice: "Alumni was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alumni
      @alumni = Alumni.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def alumni_params
      params.fetch(:alumni)
    end

    # Used to direct user to create new alumni, if needed
    private
    def force_new_alumni
      if current_user.alumni == nil
        # Redirect to new page
        redirect_to new_alumni_path
      end
    end
end
