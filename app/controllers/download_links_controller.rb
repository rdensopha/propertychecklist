class DownloadLinksController < ApplicationController
  # GET /download_links
  # GET /download_links.json
  load_and_authorize_resource
  def index
    @download_links = DownloadLink.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @download_links }
    end
  end

  # GET /download_links/1
  # GET /download_links/1.json
  def show
    @download_link = DownloadLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @download_link }
    end
  end

  # GET /download_links/new
  # GET /download_links/new.json
  def new
    @download_link = DownloadLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @download_link }
    end
  end

  # GET /download_links/1/edit
  def edit
    @download_link = DownloadLink.find(params[:id])
  end

  # POST /download_links
  # POST /download_links.json
  def create
    @download_link = DownloadLink.new(params[:download_link])
    @download_link.status = APP_CONFIG['active']
    respond_to do |format|
      if @download_link.save
        format.html { redirect_to @download_link, notice: 'Download link was successfully created.' }
        format.json { render json: @download_link, status: :created, location: @download_link }
      else
        format.html { render action: "new" }
        format.json { render json: @download_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /download_links/1
  # PUT /download_links/1.json
  def update
    @download_link = DownloadLink.find(params[:id])

    respond_to do |format|
      if @download_link.update_attributes(params[:download_link])
        format.html { redirect_to @download_link, notice: 'Download link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @download_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /download_links/1
  # DELETE /download_links/1.json
  def destroy
    @download_link = DownloadLink.find(params[:id])
    @download_link.destroy

    respond_to do |format|
      format.html { redirect_to download_links_url }
      format.json { head :no_content }
    end
  end
end
