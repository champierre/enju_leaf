class ImportRequestsController < ApplicationController
  load_and_authorize_resource

  # GET /import_requests
  # GET /import_requests.json
  def index
    @import_requests = ImportRequest.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @import_requests }
    end
  end

  # GET /import_requests/1
  # GET /import_requests/1.json
  def show
    @import_request = ImportRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @import_request }
    end
  end

  # GET /import_requests/new
  # GET /import_requests/new.json
  def new
    @import_request = ImportRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @import_request }
    end
  end

  # GET /import_requests/1/edit
  def edit
    @import_request = ImportRequest.find(params[:id])
  end

  # POST /import_requests
  # POST /import_requests.json
  def create
    @import_request = ImportRequest.new(params[:import_request])
    @import_request.user = current_user

    respond_to do |format|
      if @import_request.save
        @import_request.import!
        format.html {
          if @import_request.manifestation
            flash[:notice] = t('controller.successfully_created', :model => t('activerecord.models.import_request'))
            redirect_to manifestation_items_url(@import_request.manifestation)
          else
            flash[:notice] = t('import_request.record_not_found')
            redirect_to new_import_request_url
          end
        }
        format.json { render :json => @import_request, :status => :created, :location => @import_request }
      else
        format.html { render :action => "new" }
        format.json { render :json => @import_request.errors, :status => :unprocessable_entity }
      end
    end
  rescue Timeout::Error
    @import_request.sm_fail!
    flash[:notice] = t('page.timed_out')
    redirect_to new_import_request_url
  end

  # PUT /import_requests/1
  # PUT /import_requests/1.json
  def update
    @import_request = ImportRequest.find(params[:id])

    respond_to do |format|
      if @import_request.update_attributes(params[:import_request])
        @import_request.import!
        flash[:notice] = t('controller.successfully_updated', :model => t('activerecord.models.import_request'))
        format.html { redirect_to(@import_request) }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @import_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /import_requests/1
  # DELETE /import_requests/1.json
  def destroy
    @import_request = ImportRequest.find(params[:id])
    @import_request.destroy

    respond_to do |format|
      format.html { redirect_to(import_requests_url) }
      format.json { head :ok }
    end
  end
end
