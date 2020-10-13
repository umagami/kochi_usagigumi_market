# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  
  def new
    @user = User.new
    # Userモデルの空のインスタンス変数を生成。
    # 会員情報入力画面（new.html.haml）でform_forというヘルパーメソッドを使うが、
    # その際にこのインスタンス変数が必要となる。
  end

  def create
    @user = User.new(sign_up_params)
    # Userモデルのインスタンス変数の中には、ストロングパラメータ（指定したキーを持つパラメーターのみを受け取るように制限するもの：例：params.require(:モデル名).permit(:キー名, :キー名)）で、
    # 取得したデータを入れている。
    unless @user.valid?
    # バリデーションが正しいかどうか且つそれが偽であれば下記処理を実行。
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    # sessionにuserのデータをattributesメソッドを使用して保存。キー”devise.regist_data”にバリュー＠userを追加してる？
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @user_profile = @user.build_user_profile
    # build＝newの意味に近く、関連づけのあるnewメソッドのようなもの。ここで@userに関連づいたuser_profileオブジェクトを生成。
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
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
