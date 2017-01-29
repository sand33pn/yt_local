class LinksController < ApplicationController
  # include Httparty
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  # GET /links.json
  def api_common
    Api::Common.save_video_viewcount
    # return Api::Common.new
  end
  def index
    # @links = Link.all
    @links = Link.order(ranking: :desc)
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        save_video_viewcount(@link)
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        save_video_viewcount(@link)
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        save_video_viewcount(@link)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        # save_video_viewcount(@link)
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:link_text, :view_count, :videoid,:published_at)
    end

    def save_video_viewcount(link)
      id = parse_youtube(link.link_text)
      puts "id = #{id}"
      # api = "https://www.googleapis.com/youtube/v3/videos?part=contentDetails,statistics&id=#{id}&key=AIzaSyBeMC4eMb_u-IqGeYRSpAzED8m5RcjTumg"
      api = "https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails,statistics&id=#{id}&key=AIzaSyBeMC4eMb_u-IqGeYRSpAzED8m5RcjTumg"
      response = HTTParty.get(api.to_s)
      link.update_attributes(:view_count => response["items"][0]["statistics"]["viewCount"],:published_at => response["items"][0]["snippet"]["publishedAt"],
        :ranking => (response["items"][0]["statistics"]["viewCount"].to_i / (Date.today - Date.parse(response["items"][0]["snippet"]["publishedAt"])).to_i ).to_f,
        :thumbnail => response["items"][0]["snippet"]["thumbnails"]["default"]["url"],
        :title => response["items"][0]["snippet"]["title"]
        )

    end

    def parse_youtube(url)
      regex = /(?:.be\/|\/watch\?v=|\/(?=p\/))([\w\/\-]+)/
      url.match(regex)[1]
    end
end
