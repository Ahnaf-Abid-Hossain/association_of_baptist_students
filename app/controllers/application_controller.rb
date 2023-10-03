class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_links

  protected
  def set_links
    @links = Link.order(order: :asc)
  end
end
