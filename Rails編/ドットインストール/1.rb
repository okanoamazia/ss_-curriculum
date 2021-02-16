#ドットインストール
#https://dotinstall.com/lessons/basic_rails_v3


■rails dbconsole
・概要
コマンドライン上からデータベースの中身の確認や編集をすることができるコマンド

・使い方
.table
テーブル一覧が表示
.select * from テーブル名
選択したテーブルのレコード全て表示

■fomr_forに複数のインスタンス変数を渡す場合
form_for([@hoge1,@hoge2])
つまり、配列で渡して且つその配列を丸括弧でくくる必要がある
