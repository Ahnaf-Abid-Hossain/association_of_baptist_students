class MeetingNotesController < ApplicationController
  before_action :set_meeting_note, only: %i[show edit update destroy]

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
    @meeting_note.user_id = current_user.id # current_user.user.id? was .id
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
