class Users::RegistrationsController < Devise::RegistrationsController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @user_profile = @user.build_user_profile
    render :new_user_profile
  end

  def create_user_profile
    @user = User.new(session["devise.regist_data"]["user"])
    @user_profile = UserProfile.new(user_profile_params)
    unless @user_profile.valid?
      flash.now[:alert] = @user_profile.errors.full_messages
      render :new_user_profile and return
    end
    @user.build_user_profile(@user_profile.attributes)
    session["user_profile"] = @user_profile.attributes
    @destination = @user.destinations.build
    render :new_destination
  end

  def create_destination
    @user = User.new(session["devise.regist_data"]["user"])
    @user_profile = UserProfile.new(session["user_profile"])
    @destination = Destination.new(destinations_params)
    unless @destination.valid?
      flash.now[:alert] = @destination.errors.full_messages
      render :new_destination and return
    end
    @user.build_user_profile(@user_profile.attributes)
    @user.destinations.build(@destination.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
    redirect_to root_path
  end



  private

  def user_profile_params
    params.require(:user_profile).permit(:family_name, :first_name, :kana_family_name, :kana_first_name, :birthday)
  end

  def destinations_params
    params.require(:destination).permit(:destination_family_name, :destination_first_name, :destination_kana_family_name, :destination_kana_first_name, :post_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number)
  end
end