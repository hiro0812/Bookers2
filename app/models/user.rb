class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         #:database_authenticatable（パスワードの正確性を検証）#:registerable（ユーザ登録や編集、削除）#:recoverable（パスワードをリセット）
         #:rememberable（ログイン情報を保存） #:validatable（email のフォーマットなどのバリデーション）

  has_many :books, dependent: :destroy #UserモデルにBookモデルを関連付ける

  has_one_attached :profile_image #profile_imageという名前でActiveStorageでプロフィール画像を保存できるように設定した。

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
