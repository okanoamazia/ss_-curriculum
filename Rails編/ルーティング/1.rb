#ルーティング
#https://railsguides.jp/routing.html

■ルーターの役割
受け取ったURLを認識し、適切なコントローラ内アクションやRackアプリケーションに割り当てる

■ルーターの仕組み
HTTP動詞（GET、POST、DELETE、PATCH）と4種類のURL (/photos,/photos/new,/photos/:id,/photos/:id/edit)によって
７種類の異なるアクションを指定する (index/new/create/show/edit/update/destroy)

■ルーティングにおけるasオプション
:asオプションを使うと、どんなルーティングにも名前を指定できる
例）
get 'exit', to: 'sessions#destroy', as: :logout
=> logout_path で /exit が呼び出される

■名前空間によるルーティングのグループ化
例）
namespace :admin do
  resources :posts
end

■ネストしたリソース
モデルの関連付けがおこなれている場合に使う
class Magazine < ApplicationRecord
  has_many :ads
end
class Ad < ApplicationRecord
  belongs_to :magazine
end
↓
resources :magazines do
  resources :ads
end

■デフォルトのルーティングに新たなルーティングを追加
①member （/photos/id/preview のようにidを必要とする場合）
resources :photos do
  member do
    get 'preview'
  end
end

②collection （/photos/searchなどのidを必要としない場合）
resources :photos do
  collection do
    get 'search'
  end
end


