# -*- encoding: utf-8 -*-
class UserGroupsController < ApplicationController
  load_and_authorize_resource
  helper_method :get_library

  # GET /user_groups
  # GET /user_groups.json
  def index
    @user_groups = UserGroup.all

    respond_to do |format|
      format.html # index.rhtml
      format.json { render :json => @user_groups.to_json }
    end
  end

  # GET /user_groups/1
  # GET /user_groups/1.json
  def show
    respond_to do |format|
      format.html # show.rhtml
      format.json { render :json => @user_group.to_json }
    end
  end

  # GET /user_groups/new
  def new
    @user_group = UserGroup.new
  end

  # GET /user_groups/1;edit
  def edit
  end

  # POST /user_groups
  # POST /user_groups.json
  def create
    @user_group = UserGroup.new(params[:user_group])

    respond_to do |format|
      if @user_group.save
        flash[:notice] = t('controller.successfully_created', :model => t('activerecord.models.user_group'))
        format.html { redirect_to user_group_url(@user_group) }
        format.json { render :json => @user_group, :status => :created, :location => @user_group }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_groups/1
  # PUT /user_groups/1.json
  def update
    if params[:position]
      @user_group.insert_at(params[:position])
      redirect_to user_groups_url
      return
    end

    respond_to do |format|
      if @user_group.update_attributes(params[:user_group])
        flash[:notice] = t('controller.successfully_updated', :model => t('activerecord.models.user_group'))
        format.html { redirect_to user_group_url(@user_group) }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user_group, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_groups/1
  # DELETE /user_groups/1.json
  def destroy
    @user_group.destroy

    respond_to do |format|
      format.html { redirect_to user_groups_url }
      format.json { head :ok }
    end
  end
end
