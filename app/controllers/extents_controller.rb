class ExtentsController < InheritedResources::Base
  respond_to :html, :json
  load_and_authorize_resource

  def update
    @extent = Extent.find(params[:id])
    if params[:position]
      @extent.insert_at(params[:position])
      redirect_to extents_url
      return
    end
    update!
  end

  def index
    @extents = @extents.page(params[:page])
  end
end
