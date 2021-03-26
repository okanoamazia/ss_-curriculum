■RESTful API(REST API)
・RESTの考え方をWeb APIに適用したもの
・特徴
URL/URIですべてのリソースを一意に識別する
クライアントがHTTPで要求（リクエスト）を送信すると、応答（レスポンス）がXMLやHTML、JSON、CSV、プレーンテキストなどで返される
リソースの操作の種類はHTTPメソッド(GET、POST、PUT、DELETE)によって指定する

■RESTful API(REST API)を理解するのに必要な知識
①Web APIとは
・HTTPなどWebの技術を用いて構築されたAPIのこと
②APIとは
・プログラムの提供する機能を外部の別のプログラムから呼び出して利用するための手順・規約のこと
・Webサービスがアプリ開発者向けに公開している機能
（https://www.otsuka-shokai.co.jp/words/api.html）
・プラットフォーム側の汎用性の高い機能を外部から手軽に利用できるように提供する仕組みのこと
（https://www.idcf.jp/words/api.html）
・ソフトウェアの一部を公開して、他のソフトウェアと機能を共有できるようにしたもの
（https://www.sejuku.net/blog/7087）

③RESTとは
・複数のアーキテクチャスタイルを組み合わせて構築した複合アーキテクチャスタイル
  ＊アーキテクチャスタイル（アーキテクチャパターン）
  https://qiita.com/cocoa-maemae/items/69fe13def286c7e37d5d
    複数のアーキテクチャに共通する性質、様式、作法あるいは流儀を指す
  ＊アーキテクチャ
    基本設計や設計思想

・4つの原則をもつ
アドレス可能性　提供する情報がURIを通して表現できること。全ての情報はURIで表現される一意なアドレスを持っていること。
ステートレス性　HTTP というプロトコルでクライアントとサーバーが通信し、クライアントのアプリケーションの状態をサーバー側で管理しないこと
接続性　　　　　情報の内部に、別の情報や(その情報の別の)状態へのリンクを含めることができること。
統一インターフェース　情報の操作(取得、作成、更新、削除)は全てHTTPメソッド(GET、POST、PUT、DELETE)を利用すること。


■エンドポイント
APIにアクセスするためのURIのこと

■APIとは
抽象）Webサービスがアプリ開発者向けに公開している機能
現場）iosやandroidからのリクエストに対して情報をレスポンスするためのもの

■Swaggerとは
①OpenAPI Specification にもとづいて構築されたツール

＊OpenAPI Specification (OAS) 
https://future-architect.github.io/articles/20191008/
https://www.cresco.co.jp/blog/entry/10829/
https://www.kabuku.co.jp/developers/open-api-introduction
APIを記述するためのフォーマット
REST APIを記述するための標準仕様

②REST APIの設計、構築、文書化、および使用に役立つ機能を提供するもの

③Swaggerの実体
https://qiita.com/gcyata/items/342073fa7607fd4082bd
https://news.mynavi.jp/itsearch/article/devsoft/2395
Swagger Spec　 YAMLやJSON形式でAPIの設計について記述したもの
Swagger Editor　Swagger Specを記載するためのエディタ
Swagger UI　　　Swagger Specからドキュメントを自動生成
Swagger Core　


■API仕様書
・APIにリクエストをするために何が必要か、APIがレスポンスとして何を返却するのかをわかりやすく解説したもの

＊仕様書
サービスなどの機能や性能を文書で表わしたもの

■Swagger Specの書き方
https://techblog.zozo.com/entry/swagger_yaml

■Swagger::Blocksについて
https://qiita.com/kymmt90/items/439868c21abe077642fa

■app/views/api/episodes/show.json.builderとは　
https://pikawaka.com/rails/jbuilder
app/views以下に〇〇.json.jbuilderのファイルを作成して、
jbuilderのオブジェクトのjsonを使うと、JSON形式の文字列のデータを作成する事が出来ます。

■RSwagとは
https://github.com/rswag/rswag
・API操作を記述およびテストするために、rspec-railsの「リクエストスペック」をSwaggerベースのDSLで拡張したもの
・API操作を簡潔で直感的な構文で記述し、それは自動的にテストを実行する
・テストが成功したら、rakeタスクを実行して、対応するSwaggerファイルを自動生成し、それらをYAMLまたはJSONエンドポイントとして公開する
・統合テストをAPIコンシューマー向けの実際のドキュメントにシームレスに移行できるもの

■rakeタスクとは
https://opiyotan.hatenablog.com/entry/rails-rake-task
https://www.ryotaku.com/entry/2019/04/17/Rake%E3%82%BF%E3%82%B9%E3%82%AF%E3%81%A8%E3%81%AF
ターミナルなどのコマンドライン上からアプリケーションを実行できる機能の一つ

■./bin/rake rswag:specs:swaggerize
https://github.com/rswag/rswag
・Rswag（gem）で決められているコマンド
・Swagger JSON ファイルを生成する

■I/F
インターフェイス

■requiredとはなにか
（ヒント？：disable_ad って必ずレスポンスとして返ると思うので、Swagger で required 設定していただきたいです。）
①Swagger::Blocksで必須項目を示す書き方
https://github.com/fotinakis/swagger-blocks

②Rswagで必須項目を示す書き方
https://github.com/rswag/rswag

■ app/models/concernsとapp/controllers/concerns とは
・特定の機能に関するロジックをモデルやコントローラーとは別に実装したい際に、このフォルダ配下にファイルを作成する
・作成した機能は複数のモデルやコントローラーで再利用できる

■ ActiveSupport::Concernとは
https://qiita.com/castaneai/items/6dc121ce6ff100614f42
https://programming-beginner-zeroichi.jp/articles/142
・RubyのMix-inをより便利にしたもの（クラスメソッドかインスタンスメソッドか考える必要がない）
・ app/models/concernsとapp/controllers/concerns の実装を容易にするActiveSupporの機能

■ v1 とは
結論ただのバージョン管理
根拠
https://wp.tech-style.info/archives/683
URLにAPIバージョンを含めるようにしましょう。大手が提供しているREST APIには必ずと言っていいほどバージョニングがされています。
これにより、REST APIを使用する開発者がAPIのバージョンを選択しやすくなり、バージョンの切り分けも容易となるメリットが有ります。
例）
http://api.example.com/1/article
http://api.example.com/v1/article/
