class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required!

  private

    def admin_required!
      redirect_to root_path,
                  alert: t('admin.not_admin') unless current_user.admin?
    end
end
