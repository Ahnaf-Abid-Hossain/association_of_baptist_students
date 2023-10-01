class AlumnisController < ApplicationController
  before_action :set_alumni, only: %i[show edit update destroy]
  before_action :force_new_alumni, only: %i[index show edit]

  # GET /alumnis or /alumnis.json
  def index
    @alumnis = Alumni.all
  end

  # GET /alumnis/1 or /alumnis/1.json
  def show
    @alumni = Alumni.find(params[:id])
    @meeting_notes = @alumni.meeting_note
  end

  # GET /alumnis/new
  def new
    @alumni = Alumni.new
  end

  # GET /alumnis/1/edit
  def edit; end

  # POST /alumnis or /alumnis.json
  def create
    @alumni = Alumni.new(alumni_params)
    @alumni.user = current_user

    respond_to do |format|
      if @alumni.save
        format.html { redirect_to(alumni_url(@alumni), notice: 'Alumni was successfully created.') }
        format.json { render(:show, status: :created, location: @alumni) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @alumni.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /alumnis/1 or /alumnis/1.json
  def update
    respond_to do |format|
      if @alumni.update(alumni_params)
        format.html { redirect_to(alumni_url(@alumni), notice: 'Alumni was successfully updated.') }
        format.json { render(:show, status: :ok, location: @alumni) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @alumni.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /alumnis/1 or /alumnis/1.json
  def destroy
    @alumni.destroy!

    respond_to do |format|
      format.html { redirect_to(alumnis_url, notice: 'Alumni was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  def temp_search
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @results = Alumni.all

    @results = if @first_name.present? || @last_name.present?
                 Alumni.where('alum_first_name ILIKE ? AND alum_last_name ILIKE ?', "%#{@first_name}%", "%#{@last_name}%")
               else
                 []
               end
    render('search')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_alumni
    @alumni = Alumni.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def alumni_params
    params.require(:alumni).permit(:alum_first_name, :alum_last_name, :alum_email, :alum_ph_num, :alum_class_year, :alum_job_field, :alum_location,
                                   :alum_status, :alum_major
    )
  end

  # Used to direct user to create new alumni, if needed

  def force_new_alumni
    if current_user.alumni.nil?
      # Redirect to new page
      redirect_to(new_alumni_path)
    end
  end
end
