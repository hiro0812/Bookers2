class Book < ApplicationRecord

  has_one_attached :image #Bookモデルにimageを持たせる
  belongs_to :user #BookモデルにUserモデルを関連付ける  ※1:Nの関係の「N」側

  validates :title, presence: true #新規投稿したbookのtitleが存在しているかを確認するバリデーション #presence:空でないこと
  validates :body, presence: true, length: {maximum: 200 }  #新規投稿したbookのbodyが存在しているかを確認するバリデーション #presence:空でないこと #length:introductionの文字数は、最大200文字まで

  def get_profile_image(width, height) #条件式を定義 ※「def」=定義するという意味
    unless profile_image.attached? #条件分岐文を定義(「unless」文は条件式が偽の場合の処理を記述するのに使われる) ※「if」の逆の意味
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg') #file_pathという箱にサンプル画像を入れている
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg') #条件式が偽の時に実行する処理1を記載
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
