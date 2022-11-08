class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?  #before_action=下記のアクション実行前にアクションをconfigure_permitted_parametersメソッド実施 #意味:
  before_action :authenticate_user!, except: [:top, :about] #before_action=下記のアクション実行前に:authenticate_user!メソッドを実施 #意味:（全てのユーザーの内）ログインしていないユーザーは（Top,Aboutページ）しか入ることが出来ません。

    def after_sign_in_path_for(resource) #after_sign_in_path_forはDeviseが用意しているメソッドであり #サインイン後にどこに遷移するかを設定しているメソッドである
      user_path(current_user) #ログイン後の遷移先を指定(users#show(current_user))
    end

    def after_sign_out_path_for(resource) #after_sign_out_path_forはafter_sign_in_path_forと同じくDeviseが用意しているメソッドであり #サインアウト後にどこに遷移するかを設定するメソッドである
      root_path #ログアウト後の推移先を指定(homes#top)
    end

    protected # protectedは呼び出された他のコントローラからも参照することができる（※privateは記述をしたコントローラ内でしか参照できない）

    # configure_permitted_parametersメソッドでは、devise_parameter_sanitizer.permitメソッドを使うことでユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可している。
    def configure_permitted_parameters # configure_permitted_parametersメソッド=devise gemで追加したいカラムを設定できる様にするメソッド
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email]) #devise_parameter_sanitizer.permitメソッド=新規登録時にemail情報も保存できる様にするメソッド #permit後の書き方は(:アクション, キー: [:追加したいカラム])となる
    end
end