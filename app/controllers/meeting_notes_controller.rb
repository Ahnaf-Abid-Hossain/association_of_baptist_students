class MeetingNotesController < ApplicationController
  before_action :set_meeting_note, only: %i[show edit update destroy]
  before_action :check_approval_status
  before_action :user_is_admin, only: %i[new create show edit]

  def user_is_admin
    unless current_user&.is_admin
      flash[:alert] = 'You do not have permission to access this page.'
      redirect_to(root_path)
    end
  end

  # GET /meeting_notes or /meeting_notes.json
  def index
    @meeting_notes = MeetingNote.all
  end

  # GET /meeting_notes/1 or /meeting_notes/1.json
  def show; end

  # GET /meeting_notes/new
  def new
    @meeting_note = MeetingNote.new
  end

  # GET /meeting_notes/1/edit
  def edit; end

  # POST /meeting_notes or /meeting_notes.json
  def create
    @meeting_note = MeetingNote.new(meeting_note_params)
    # current_user.user.id? was .id
    @meeting_note.user_id = current_user.id
    respond_to do |format|
      if @meeting_note.save
        format.html { redirect_to(meeting_note_url(@meeting_note), notice: 'Meeting note was successfully created.') }
        format.json { render(:show, status: :created, location: @meeting_note) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @meeting_note.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /meeting_notes/1 or /meeting_notes/1.json
  def update
    respond_to do |format|
      if @meeting_note.update(meeting_note_params)
        format.html { redirect_to(meeting_note_url(@meeting_note), notice: 'Meeting note was successfully updated.') }
        format.json { render(:show, status: :ok, location: @meeting_note) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @meeting_note.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /meeting_notes/1 or /meeting_notes/1.json
  def destroy
    @meeting_note.destroy!

    respond_to do |format|
      format.html { redirect_to(meeting_notes_url, notice: 'Meeting note was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  def search_meeting
    @meeting_notes2 = if params[:search_date]
                        MeetingNote.where(date: Date.parse(params[:search_date]))
                      else
                        MeetingNote.all
                      end
    respond_to do |format|
      format.html # This will render the default HTML template (if it exists)
      format.json { render(json: @meeting_notes) } # Render JSON for JSON requests
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meeting_note
    @meeting_note = MeetingNote.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def meeting_note_params
    params.require(:meeting_note).permit(:title, :content, :date, :id)
  end
end
