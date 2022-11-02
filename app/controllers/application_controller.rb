class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:top, :about] #ログインしていないユーザーは（Top,Aboutページ）しか入ることが出来ません。という意味

    def after_sign_in_path_for(resource)
      users_path #ログイン後の遷移先を指定
    end

    def after_sign_out_path_for(resource)
      root_path #ログアウト後の推移先を指定
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    end
end