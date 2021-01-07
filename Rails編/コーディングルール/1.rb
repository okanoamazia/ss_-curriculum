#コーディングルール
#https://github.com/satour/rails-style-guide/blob/master/README-jaJA.md


■Configuration
・アプリケーション起動時の処理をカスタマイズしたい場合
config/initializers 配下にその処理を記述したコードを配置する（∵config/initializers 配下のコードはアプリケーション起動時に実行される）

・3つの環境（development、test、 production）毎に適切な設定をしたい
config/environments/配下にある、それぞれの環境に対応した設定ファイルを編集する
（＊設定をすべての環境に適用したい場合は、 config/application.rb に記述する）

・production環境と同環境の staging 環境を作成する

■Routing
・RESTfulなresourceにアクションを追加する場合（そのようなアクションが本当に必要かはわかりませんが）、 member と collection を利用する
・ActiveRecordのモデル間の関連を表現するには、入れ子型でルートを定義する
・関連する アクション・ルートをまとめるには namespaceを利用する

■Controller
・ビジネスロジックは controller でなく model に書く
・controller の役割
view層にデータを渡すこと、またはview層からデータを受け取ることのいずれか
（＊それ以外のコードは controller に記述しないようにする）
・controller と view の間でやりとりするインスタンス変数は2つまでにする

■Models
・has_manyやvalidatesなどはクラス定義の最初の方に記述する
・なるべくhas_and_belongs_to_manyよりhas_many :throughを利用する
・ActiveRecordのオブジェクトに対して繰り返し処理を行う場合は、（all.eachではなくて）find_eachを利用する
・SQLインジェクション攻撃を防ぐため、クエリの文字列の中で式を展開するのはやめる
# bad - paramがエスケープされず、SQLインジェクションの可能性が残る。
Client.where("orders_count = #{params[:orders]}")
# good - paramがエスケープされる
Client.where('orders_count = ?', params[:orders])
・クエリのなかで2つ以上のプレースホルダを使う場合は、 名前付きプレースホルダを利用する
# okish
Client.where(
  'created_at >= ? AND created_at <= ?',
  params[:start_date], params[:end_date]
)
# good
Client.where(
  'created_at >= :start_date AND created_at <= :end_date',
  start_date: params[:start_date], end_date: params[:end_date]
)

■Migrations
・schema.rb (または structure.sql) は必ずバージョン管理する

■Views
・同じコードを複数箇所に書くのは非効率です。複数のviewで同じコードを書く場合は、部分テンプレートやレイアウトにまとめる

■Internationalization
・国際化（国や土地によって文字列を翻訳する）したい文字列は、すべてconfig/locales配下のlocaleファイル（辞書ファイル）で定義する
・ActiveRecord の model の対訳と view で使用するテキストは別々の辞書ファイルに定義する
・挙動が同じなら、利用するメソッドは名称が短い方が望ましい。I18n.translateではなくI18n.t。また、I18n.localizeでなく、I18n.lを使う。

■Assets
・app/assets配下
独自のstylesheetファイル・javascriptファイル・画像ファイル
・lib/assets配下
開発中のアプリケーションに必ずしもフィットしていない独自ライブラリ
・vendor/assets配下
jQueryや bootstrapのようなサードパーティーのコード

■Time
・application.rb でtimezoneを適切に設定
・Time.nowは使わないようにする
# bad
Time.now # => システム日付を返します。その際、timezoneの設定は無視されます。
# good
Time.zone.now # => Fri, 12 Mar 2014 22:04:47 EET +02:00
Time.current # 上記と同じ処理で、より短い記法です。

■Bundler
・開発およびテストでしか利用しない gem は、Gemfileにて利用する環境（developmentやtest）を指定する

■Flawed Gems
・rmagick→minimagick
・autotest→guard や watchr
・rcov→SimpleCov
・therubyracer→node.js

■
