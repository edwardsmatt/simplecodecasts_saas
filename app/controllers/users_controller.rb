class UsersController < ApplicationController
  before_filter :find_model
  before_action :authenticate_user!

  def show

  end

  private
  def find_model
    @user = User.find(params[:id]) if params[:id]
  end
end