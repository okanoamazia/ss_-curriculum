#dynamoid
https://github.com/Dynamoid/dynamoid
https://dev.classmethod.jp/articles/ror-to-dynamoid/
https://qiita.com/maecho/items/ddf47e97ceee594f1bd6
https://developer.feedforce.jp/entry/2017/11/04/235323
https://tanaaaaka.hatenablog.com/entry/2017/07/06/141829
https://www.takayasugiyama.com/entry/2020/12/01/023707

■Dynamoid
・is an ORM for Amazon's DynamoDB for Ruby applications.
・provides similar functionality to ActiveRecord
・improves on Amazon's existing HashModel by providing better searching tools and native association support.
・Railsの中でActiveRecordのようにDynamoDBと連携できるO/Rマッパー

＊O/Rマッピング（ORM）
・オブジェクト指向言語におけるオブジェクトと、リレーショナルデータベースにおけるレコードとを対応付けること
・ORM用のライブラリをO/Rマッパーと呼ぶ

＊similar A to  B
・Bに似ているA
・例）This is a similar T-shirt to the one I got from my friend.（これは友達からもらったTシャツに似ている。）

■Dynamoidの使い方
https://github.com/Dynamoid/dynamoid
https://tanaaaaka.hatenablog.com/entry/2017/07/06/141829   ＊特にこれが流れとしてはわかりやすい
https://dev.classmethod.jp/articles/ror-to-dynamoid/
https://qiita.com/maecho/items/ddf47e97ceee594f1bd6
１，gem 'dynamoid'
２，aws.rbとdynamoid.rbで設定
３，DynamoDBにアクセスするモデルを作成
（ActiveRecordで、ApplicationRecordをクラスに継承させてRDBMSにアクセスするモデルを作っているの同じような流れ）
（だから、Dynamoid::Documentをincludeするのは必須）
例）
class Book
  include Dynamoid::Document

  table :name => "book_table", :key => :book_id

  field :title
end
４，あとはActiveRecordとだいたい同じようにデータ読み書きできる
$ bundle exec rails c
> book = Book.new
=> #<Book:0x007fc9c54935b8
> book.book_id = "id111" #idは適当に決める
=> "id111"
> book.title = "Effective Ruby" #fieldを決める
=> "Effective Ruby"
> book.save

■aws-sdk
https://awsjp.com/AWS/hikaku/AWS-Service-access-hikaku.html
・プログラムの中に組み込んでAWSへアクセスするプログラムを開発する。
・プログラムを開発しアクセスキー/シークレットアクセスキーによりAWSサービスにアクセス。
・ブラウザ経由でアクセスするのがコンソール（GUI）、コマンドラインからアクセスするのが（AWS CLI）、プログラムそのものからアクセスするのが（AWS SDK）

＊SDK
https://techtarget.itmedia.co.jp/tt/news/1911/07/news06.html
・software development kitの略称であり、日本語ではソフトウェア開発キット
・特定のソフトウェアを開発する際に必要なツールのセット（APIのライブラリ、サンプルプログラム、技術文書などが含まれる）のこと
・少ない労力でアプリケーションを開発できるようにするために、プログラム、API、サンプルコードなどをパッケージにしたもの


ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
【そもそもDynamoDBについて】
https://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/developerguide/HowItWorks.Partitions.html

■DynamoDB（この部分はdynamoidのREADMEに書いてあった）
・a fast, scalable, simple, easy-to-use database
・not like other document-based databases , and is very different  from relational databases.
・cannot provide complicated relational queries and transaction support
・Amazon Web Servicesが提供するフルマネージドNoSQLデータベースサービス

＊NoSQL（Not Only SQL ）
リレーショナルデータベースの問題点を解消したもの、RDBMS以外のDBシステムを指す大まかな定義の単語
（RDBMS リレーショナルデータベース管理システム、relational database management system）

＊ドキュメントデータベース
非リレーショナルデータベースの一種

＊トランザクション
https://www.atmarkit.co.jp/ait/articles/0803/24/news138.html
・複数のデータ更新処理を1つの単位にまとめ、管理する際の処理単位のこと


■DynamoDBのテーブル（table）（例：Peopleテーブル）
・テーブルは、項目のコレクション
・各テーブルにはゼロ以上の項目がある
・他のデータベースシステムで言うテーブルに似ているもの
・作成するにはテーブル名とプライマリーキーのみ指定する必要がある（他の属性は事前に定義する必要はない）

■DynamoDBの項目（item）（（例：Peopleテーブルにおける1人のperson）
・属性のコレクション
・各項目は 1 つ以上の属性で構成される
・各項目は重複しない
・他のデータベースシステムで言うレコード・行に似ているもの

■DynamoDBの属性（attribute）（例：Peopleテーブルにおける1人のpersonがもつnameやphonenumberといった項目）
・属性は、基盤となるデータ要素であり、それ以上分割する必要がないもの
・他のデータベースシステムで言うカラム・列に似ているもの

■DynamoDBのプライマリーキー
・各項目が重複しないように分けるためのもの
・２種類ある
    ①パーティションキー（ハッシュ属性、ハッシュキー）
      1つの属性で構成される。2つの項目が同じパーティションキー値を持つことはできない。
    ②パーティションキーとソートキー（範囲属性、レンジキー）
      2つの属性で構成される。複合プライマリキーと呼ばれる。2つの属性からなり最初の属性はパーティションキー、2つめの属性はソートキー。
      この時のみ、2つの項目がパーティションキー値を持つことがあるが、ソートキー値は 2 つの項目で必ず異なる

■キー属性
パーティションキー、ソートキーの属性のこと

■セカンダリインデックス
・テーブルで 1 つ以上作成できる
・プライマリキーに対するクエリとは別に、代替キーを使用して、テーブル内のデータのクエリを実行する
・２種類ある
    ①グローバルセカンダリインデックス – テーブルと異なるパーティションキーとソートキーを持つインデックス
    ②ローカルセカンダリインデックス    – テーブルと同じパーティションキーと、異なるソートキーを持つインデックス。

＊クエリ
・データベースさんに対する「おい！これやれよ」な命令文のこと。
・データベース管理システムに対する問合せ（処理要求）
・データベースからデータを抽出したり操作したりといった処理を行うための命令のことである。「問合せ」。

■DynamoDBの読み込み/書き込みのキャパシティーに関するモード
①オンデマンドモード
容量計画なしで 1 秒あたりに数千ものリクエストを処理できる柔軟な設定

②プロビジョニングモード
アプリケーションに必要な 1 秒あたりの読み込みと書き込みの回数を指定する設定

■DynamoDBのパーティション（一般的には記憶領域の区分という意味の言葉）
・テーブル用のストレージの割り当て
・1つのテーブルに複数のパーティションが作られて、その中に項目が保存される

■そもそもパーティションキーとは
https://qiita.com/shibataka000/items/e3f3792201d6fcc397fd
・データをどのパーティションに配置するか決定する属性

■そもそもソートキーとは
・パーティション内でデータを並べ替えて物理的に近くなるように配置する属性

＊スループット
コンピュータやネットワークが一定時間内に処理できるデータ量のこと

＊インデックス
・インデックスとはテーブルの情報を探す時に検索の対象としてよく使用するカラムの値だけを取り出して検索しやすいようにしておいたもの
・INDEXを作成すると、データテーブルとは別に検索用に最適化された状態でデータが保存される
https://qiita.com/C058/items/1c9c57f634ebf54d99bb
https://itsakura.com/sql-index
https://style.potepan.com/articles/25208.html
https://www.dbonline.jp/sqlite/index/index1.html

＊複合インデックス
複数の並び替え条件でインデックスを作ること
https://qiita.com/towtow/items/4089dad004b7c25985e3

＊サブセット
一部分、部分集合、下位集合などの意味を持つ英単語。 ある集団全体を構成する要素の一部を取り出して構成した小集団のこと
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
【過去DynamoDB関連のインプット】
■DynamoDBのキーの名前
      昔                      今
ハッシュキー → パーティションキー
レンジキー     → ソートキー


・インデックスとキー
https://dev.classmethod.jp/articles/conceptual-learning-about-dynamodb-index/
・図
https://www.slideshare.net/AmazonWebServicesJapan/aws-black-belt-online-seminar-2018-amazon-dynamodb-advanced-design-pattern
