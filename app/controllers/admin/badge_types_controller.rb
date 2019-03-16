class BadgeTypesController < Admin::BaseController
  before_action :set_badge_type, only: [:show, :edit, :update, :destroy]

  # GET /badge_types
  # GET /badge_types.json
  def index
    @badge_types = BadgeType.all
  end

  # GET /badge_types/1
  # GET /badge_types/1.json
  def show
  end

  # GET /badge_types/new
  def new
    @badge_type = BadgeType.new
  end

  # GET /badge_types/1/edit
  def edit
  end

  # POST /badge_types
  # POST /badge_types.json
  def create
    @badge_type = BadgeType.new(badge_type_params)

    respond_to do |format|
      if @badge_type.save
        format.html { redirect_to @badge_type, notice: 'Badge type was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /badge_types/1
  # PATCH/PUT /badge_types/1.json
  def update
    respond_to do |format|
      if @badge_type.update(badge_type_params)
        format.html { redirect_to @badge_type, notice: 'Badge type was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /badge_types/1
  # DELETE /badge_types/1.json
  def destroy
    @badge_type.destroy
    respond_to do |format|
      format.html { redirect_to badge_types_url, notice: 'Badge type was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_badge_type
      @badge_type = BadgeType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def badge_type_params
      params.require(:badge_type).permit(:type, :name)
    end
end
