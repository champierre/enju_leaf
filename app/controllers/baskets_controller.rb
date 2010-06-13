class BasketsController < ApplicationController
  before_filter :check_client_ip_address
  load_and_authorize_resource
  before_filter :get_user, :except => [:new, :create]
  #cache_sweeper :resource_sweeper, :only => [:create, :update, :destroy]

  # GET /baskets
  # GET /baskets.xml
  def index
    @baskets = @user.baskets.paginate(:all, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @baskets }
    end
  end

  # GET /baskets/1
  # GET /baskets/1.xml
  def show
    @basket = Basket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @basket }
    end
  end

  # GET /baskets/new
  # GET /baskets/new.xml
  def new
    @basket = Basket.new
    @basket.user_number = params[:user_number]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @basket }
    end
  end

  # GET /baskets/1/edit
  def edit
    @basket = Basket.find(params[:id])
  end

  # POST /baskets
  # POST /baskets.xml
  def create
    @basket = Basket.new
    @user = User.first(:conditions => {:user_number => params[:basket][:user_number]}) rescue nil
    if @user
      unless @user.user_number.blank?
        @basket.user = @user
      end
    end

    respond_to do |format|
      if @basket.save
        flash[:notice] = t('controller.successfully_created', :model => t('activerecord.models.basket'))
        format.html { redirect_to user_basket_checked_items_url(@user.username, @basket) }
        format.xml  { render :xml => @basket, :status => :created, :location => @basket }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @basket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /baskets/1
  # PUT /baskets/1.xml
  def update
    @basket = Basket.find(params[:id])
    #if params[:mode] == 'checkout'
    librarian = current_user
    unless @basket.basket_checkout(librarian)
      redirect_to user_basket_checked_items_url(@basket.user.username, @basket)
      return
    end

    #@checkout_count = @basket.user.checkouts.count
    respond_to do |format|
      #if @basket.update_attributes({})
      if @basket.save(:validate => false)
        # 貸出完了時
        flash[:notice] = t('basket.checkout_completed')
        format.html { redirect_to(user_checkouts_url(@basket.user.username)) }
        format.xml  { head :ok }
      else
        format.html { redirect_to(user_basket_checked_items_url(@basket.user.username, @basket)) }
        format.xml  { head :ok }
      end
    end

  end

  # DELETE /baskets/1
  # DELETE /baskets/1.xml
  def destroy
    @basket = Basket.find(params[:id])
    @basket.destroy

    respond_to do |format|
      #format.html { redirect_to(user_baskets_url(@user)) }
      format.html { redirect_to(user_checkouts_url(@basket.user.username)) }
      format.xml  { head :ok }
    end
  end

end