class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         #:database_authenticatable（パスワードの正確性を検証）#:registerable（ユーザ登録や編集、削除）#:recoverable（パスワードをリセット）
         #:rememberable（ログイン情報を保存） #:validatable（email のフォーマットなどのバリデーション）

  has_many :books, dependent: :destroy #UserモデルにBookモデルを関連付ける ※1:Nの関係の「1」側

  has_one_attached :profile_image #profile_imageという名前でActiveStorageでプロフィール画像を保存できるように設定した。

  def get_profile_image(width, height) #条件式を定義 ※「def」=定義するという意味
    unless profile_image.attached? #条件分岐文を定義(「unless」文は条件式が偽の場合の処理を記述するのに使われる) ※「if」の逆の意味
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg') #file_pathという箱にサンプル画像を入れている
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg') #条件式が偽の時に実行する処理1を記載
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
