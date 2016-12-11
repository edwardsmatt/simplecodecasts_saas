class ProfilesController < ApplicationController
  before_filter :find_model

  def new
    # form where a user can fill out their own profile.
    @profile = Profile.new
  end

  def create
    @profile = @user.build_profile(profile_params)
    if @profile.save
      flash[:success] = "Profile Updated!"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end

  def edit
    @profile = @user.profile
  end

  private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
  end

  def find_model
    @user = User.find(params[:user_id]) if params[:user_id]
  end
end
