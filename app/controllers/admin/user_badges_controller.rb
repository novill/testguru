class Admin::UserBadgesController < Admin::BaseController
  before_action :set_user_badge, only: [:show, :edit, :update, :destroy]

  # GET /user_badges
  # GET /user_badges.json
  def index
    @user_badges = UserBadge.all
  end

  # GET /user_badges/1
  # GET /user_badges/1.json
  def show
  end

  # GET /user_badges/new
  def new
    @user_badge = UserBadge.new
  end

  # GET /user_badges/1/edit
  def edit
  end

  # POST /user_badges
  # POST /user_badges.json
  def create
    @user_badge = UserBadge.new(user_badge_params)

    respond_to do |format|
      if @user_badge.save
        format.html { redirect_to admin_user_badge_path(@user_badge), notice: 'User badge was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /user_badges/1
  # PATCH/PUT /user_badges/1.json
  def update
    respond_to do |format|
      if @user_badge.update(user_badge_params)
        format.html { redirect_to admin_user_badge_path(@user_badge), notice: 'User badge was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /user_badges/1
  # DELETE /user_badges/1.json
  def destroy
    @user_badge.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_badges_url, notice: 'User badge was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_badge
      @user_badge = UserBadge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_badge_params
      params.require(:user_badge).permit(:badge_id, :user_id, :count)
    end
end
