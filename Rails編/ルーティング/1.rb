#ルーティング
#https://railsguides.jp/routing.html

■ルーターの役割
・受け取ったHTTPリクエストを認識し、適切なコントローラ内アクションに割り当てる
例）
root 'welcome#index' （root  to: 'welcome#index' の省略、getは書かない決まりだが、HTTPリクエスト のメソッドとしてはget。3.14に記載あり）
get '/patients/:id', to: 'patients#show'

・パスやURLを生成することもできる
例）
get '/patients/:id', to: 'patients#show', as: 'patient'
patient GET    /patients/:id(.:format)      patients#show
=>patient_path(@patient.id)というパス作れている

＊ちなみに get '/patients/:id', to: 'patients#show' だけなら
            GET    /patients/:id(.:format)      patients#show


■リソースベースのルーティング
・リソースベースで構成されたコントローラに対応する共通のルーティングを手軽に宣言できる
・HTTPメソッド（GET、POST、DELETE、PATCH）と4種類のURL 「/users」、「/users/new」、「/users/:id」、「/users/:id/edit」によって
７種類の異なるアクションを指定する (index/new/create/show/edit/update/destroy)
・パスとURL用ヘルパーが利用可能になる
GET      「/users」               index               users_path
POST    「/users」               create             users_path
GET      「/users/new」      new                 new_user_path
GET      「/users/:id」         show               user_path(:id)
PATCH  「/users/:id」         update            user_path(:id)
DELETE「/users/:id」         delete              user_path(:id)
GET      「/users/:id/edit」  edit                 edit_user_path(:id)

＊パスやURL用ヘルパーにおける省略
下記は全部同義
<%= link_to '詳細', user_path(@user.id) %
<%= link_to '詳細', user_path(@user) %
<%= link_to '詳細', @user %


■REST（Webを支える技術）
・複数のアーキテクチャスタイルを組み合わせて構築した複合アーキテクチャスタイル
・具体的には
  クライアント/サーバー：HTTP というプロトコルでクライアントとサーバーが通信すること
  ステートレスサーバー：クライアントのアプリケーションの状態をサーバー側で管理しないこと
  キャッシュ              ：一度サーバーから取得したリソースをクライアント側で使い回す方式のこと
  統一インターフェイス：情報の操作(取得、作成、更新、削除)は全てHTTPメソッド(GET、POST、PUT、DELETE)を利用すること。
  階層化システム
  コードオンデマンド

  ＊アーキテクチャスタイル
  https://qiita.com/cocoa-maemae/items/69fe13def286c7e37d5d
    複数のアーキテクチャに共通する性質、様式、作法あるいは流儀を指す

  ＊アーキテクチャ
    基本設計や設計思想

■リソース
・Web 上にある名前をもったありとあらゆる情報のこと
・このリソースの名前がURI
・URI は必ず何か1つのリソースを指す
・逆にリソースは複数のURIを持つことができる

＊URIとは
https://www.geekly.co.jp/column/cat-webgame/1911_012/
URL と URN の総称
URL：Web上の住所
URN：Web側で認識されている名前





■名前空間によるルーティングのグループ化
例）＊この時コントローラーは app/controllers/admin/users_controller.rb
namespace :admin do
  resources :users
end

GET      「admin/users」               index               admin_users_path
POST    「admin/users」               create             admin_users_path
GET      「admin/users/new」      new                 new_admin_user_path
GET      「admin/users/:id」         show               admin_user_path(:id)
PATCH  「admin/users/:id」         update            admin_user_path(:id)
DELETE「admin/users/:id」         delete              admin_user_path(:id)
GET      「admin/users/:id/edit」  edit                 edit_admin_user_path(:id)



■ネストしたリソース
・モデルの関連付けがおこなれている場合に使う
・モデルの親子関係をルーティングで表すことができる

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

■RESTful なルーティングに新たなアクションを追加
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

■ルーティングの「concern」機能
・concernを使うことで、他のリソースやルーティング内で使いまわせる共通のルーティングを宣言できます。concernは以下のように定義します。
例）
concern :commentable do
  resources :comments
end

resources :messages, concerns: :commentable
  ↓ 下と一緒
resources :messages do
  resources :comments
end


■ルーティングにおけるasオプション
:asオプションを使うと、どんなルーティングにも名前を指定できる（hoge_pathやhoge_urlを作成できる）
例）
get 'exit', to: 'sessions#destroy', as: :logout
=> logout_path で /exit が呼び出される

■ルーティングの調査
・rake routes | grep hoge で hoge が含まれるルーティングを検索可能
