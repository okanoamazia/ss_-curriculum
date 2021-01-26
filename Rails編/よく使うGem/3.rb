#config
■　configとは
環境ごとに異なる定数をシンプルに管理するためのgem

■　configの使い方
１，gem 'config'
２，bundle exec rails g config:install
３，定数を定義
例）
  service:
    name: 'vdeep'
    url: 'http://vdeep.net'

  Settings.service.name　  #=> "vdeep"
  Settings.service[:name]   #=> "vdeep"
  Settings[:service][:name] #=> "vdeep"

■　rails g config:installで生成されるファイルとその役割
config/initializers/config.rb	           configの設定ファイル
config/settings.yml	                      すべての環境で利用する定数を定義
config/settings.local.yml	              ローカル環境のみで利用する定数を定義
config/settings/development.yml	 開発環境のみで利用する定数を定義
config/settings/production.yml	   本番環境のみで利用する定数を定義
config/settings/test.yml	              テスト環境のみで利用する定数を定義

■　URL
https://github.com/rubyconfig/config
http://vdeep.net/rubyonrails-config-gem
http://shimadays.com/2018/07/30/configgem/
https://qiita.com/beanbeenzou/items/87fb89f73e1b9e6490e1


■　参考：gemではなく元々Railsにあるconfigディレクトリについて
https://www.buildinsider.net/web/rubyonrails4/0205
https://railsdoc.com/config
・config/以下の設定ファイルによって設定を変更
・よく利用されるファイル
   application.rb	          すべての環境で共通の設定ファイル
   environment/	 	          環境ごとの設定ファイルを格納するディレクトリ
          development.rb	 開発環境での設定ファイル
          test.rb	               テスト環境での設定ファイル
          production.rb	    本番環境での設定ファイル
   initializers/	 	            その他の初期化処理や設定情報などを格納するディレクトリ
          infiections.rb	    単数形・複数形のルールを設定
          mime_types.rb	   アプリケーションで利用できるコンテンツタイプ
          secret_token.rb	  クッキーを署名とするためのトークン情報
          session_store.rb	セッションを保存するための設定ファイル
    locales/	 	                 国際化対応のためのリソースファイルを格納するディレクトリ
・ファイル内での設定方法
    config.パラメータ = 値
