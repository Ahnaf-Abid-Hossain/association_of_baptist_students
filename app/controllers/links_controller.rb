class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy up down]
  before_action :forbid_non_admin, only: %i[create update destroy up down]
  before_action :redirect_non_admin, only: %i[index show new edit]

  # GET /links or /links.json
  def index; end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit; end

  # POST /links or /links.json
  def create
    @link = Link.new(link_params)
    @link.user = current_user
    @link.order = Link.get_next_order

    # Prepend http:// if not present
    @link.url = "http://#{@link.url}" if @link.url && !@link.url.start_with?('http://', 'https://')

    respond_to do |format|
      if @link.save
        format.html { redirect_to(links_url, notice: 'Link was successfully created.') }
        format.json { render(:show, status: :created, location: @link) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @link.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    new_params = link_params
    new_params[:url] = "http://#{new_params[:url]}" if new_params[:url] && !new_params[:url].start_with?('http://', 'https://')

    respond_to do |format|
      if @link.update(new_params)
        format.html { redirect_to(link_url(@link), notice: 'Link was successfully updated.') }
        format.json { render(:show, status: :ok, location: @link) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @link.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy!
    Link.reorder_links

    respond_to do |format|
      format.html { redirect_to(links_url, notice: 'Link was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  # PATCH /links/1/up
  def up
    # Only move links >1 up
    if @link.order > 1
      # Bad things happen if we fail here
      before = Link.find_by(order: @link.order - 1)

      # Swap orders
      @link.order -= 1
      before.order += 1

      # Save
      @link.save!
      before.save!

      # Redirect back to links
      redirect_to(links_url)
    end
  end

  # PATCH /links/1/down
  def down
    # Only move links < LENGTH - 1
    if @link.order < Link.count
      # Bad things happen if we fail here
      after = Link.find_by(order: @link.order + 1)

      # Swap orders
      @link.order += 1
      after.order -= 1

      # Save
      @link.save!
      after.save!

      # Redirect back to links
      redirect_to(links_url)
    end
  end

  def help; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:label, :url)
  end

  def forbid_non_admin
    head(:forbidden) unless current_user.is_admin
  end

  def redirect_non_admin
    redirect_to(root_path) unless current_user.is_admin
  end
end
