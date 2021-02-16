#Active Record
#コールバック
#https://railsguides.jp/active_record_callbacks.html

■オブジェクトのライフサイクルとは
Railsアプリケーションにおいて、オブジェクトが作成されたり、更新されたりdestroyされたりすること

■コールバックとは
・オブジェクトのライフサイクル期間の特定の瞬間に呼び出されるメソッドのこと（例：作成/保存/更新/削除/検証/データベースからの読み込み等）
・オブジェクトの状態が切り替わる「前」または「後」にロジックをトリガする
・コールバックのbefore/after_hogeのhogeが指す瞬間の前/後に、コールバックに続くメソッド、もしくはブロックの内容を実行する

＊トリガ（トリガー）
・きっかけとなる何かのこと
・作動させる

■コールバックの利用方法
コールバック :メソッド名
or
コールバック ブロック（do ~ end）
before_validation
例）
class Article < ActiveRecord::Base
  validates :title, presence: true

  before_validation :set_nameless_name

  private
   def set_nameless_name
    self.title = "no name" if title.blank?    ＊この時のselfはArticleのインスタンス（∵ クラスの中のメソッドの中のself  →  定義されているクラスのインスタンスを指す）
   end
end

a1=Article.new
a1.save
a1
=> #<Article id: nil, title: "no name", text: nil, created_at: nil, updated_at: nil>


■コールバックの一覧
・オブジェクトの作成
    before_validation
    after_validation
    before_save
    around_save
    before_create
    around_create
    after_create
    after_save
    after_commit/after_rollback

・オブジェクトの更新
    before_validation
    after_validation
    before_save
    around_save
    before_update
    around_update
    after_update
    after_save
    after_commit/after_rollback

・オブジェクトのdestroy
    before_destroy
    around_destroy
    after_destroy
    after_commit/after_rollback


＊キュー
https://medium-company.com/queue/
データ構造の一つ（データを格納する入れ物）で、入ってきたデータを順番に格納し、先に格納したデータから順に取り出す、 先入れ先出し（FIFO：First-In First-Out）方式のデータ構造です。

＊トランザクション
https://qiita.com/tomokiyao/items/8697b523a0a5b9cf0bec
https://web-camp.io/magazine/archives/18310
データの不整合性防ぐために、複数の処理をまとめて１つの大きな処理として扱うこと

■条件付きコールバック
バリデーションと同様に :if, :unlessオプションが使え、引数も同様にシンボル、Proc、Arrayを使える
例）
class Order < ApplicationRecord
  before_save :normalize_card_number, if: :paid_with_card?

  def paid_with_card?
    payment_type == "card"
  end
end
