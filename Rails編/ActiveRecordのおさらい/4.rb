#Active Record
#クエリインターフェイス
#https://railsguides.jp/active_record_querying.html

■ Active Recordでのデータベース操作
Active Recordは、ユーザーに代わってデータベースにクエリを発行します。
発行されるクエリは多くのデータベースシステム (MySQL、MariaDB、PostgreSQL、SQLiteなど) と互換性があります。
Active Recordを使用していれば、利用しているデータベースシステムの種類にかかわらず、同じ表記を使用できます。

■ 特に記さない限り、モデル中のidは主キーを表します。

■ findメソッド
・概要
主キー（id）でオブジェクトを検索
・例
clients = Client.find(1, 10)
# => [
# <Client id: 1, first_name: "Lifo">,
# <Client id: 10, first_name: "Ryan">
# ]

■ takeメソッド
・概要
レコードを指定数取り出す（デフォルトは1つ）（＊主キー順ではないので注意）
・例
clients = Client.take(2)
# => [
#   #<Client id: 1, first_name: "Lifo">,
#   #<Client id: 220, first_name: "Sara">
# ]

■ firstメソッド
・概要
主キー順でレコードを指定数取り出す（デフォルトは一番最初のもの）
＊逆がlastメソッド
・例
clients = Client.first(3)
# => [
#   #<Client id: 1, first_name: "Lifo">,
#   #<Client id: 2, first_name: "Fifo">,
#   #<Client id: 3, first_name: "Filo">
# ]

■ find_byメソッド
与えられた条件にマッチするレコードのうち最初のレコードだけを返す
（findとの違いは主キー以外も検索できる点と取り出せるレコード数は逆に１つのみという点）
                検索条件      レコード数
find             主キー         指定数
find_by        何でも            1


■ ハッシュの書き方
exam = {"subject" => "Math", "score" => 80}   キーが文字列
exam = { :subject => "Math",  :score => 80}    キーがシンボル
exam = { subject:"Math"      , score:80}          キーがシンボルの省略形

■ ハッシュの取り出し方
ハッシュ名[:キー]

■ whereメソッドでの検索の仕方
・概要
最初の文字列で表された引数を、検索の条件として受け取ります。（これを条件文字列とも言う）
条件文字列には変数をそのままおいてはいけない
✗文字列指定
✗Client.where("orders_count = #{params[:orders]}")
↓
正しい書き方
①配列で疑問符？を使った方法（条件文字列で指定した？に2つ目以降の引数がはいる）
条件1つ  Client.where("orders_count = ?", params[:orders])
条件2つ  Client.where("orders_count = ? AND locked = ?", params[:orders], false)

②プレースホルダを使った方法
Client.where("id = :id", {id: params[:id]})
#Client.where("id = :id",  {:id => params[:id]} ) と同義
つまり条件文字列でシンボルを指定し、そのシンボルをキーとするハッシュのバリューを渡す形

③ハッシュを使った方法（シンボル指定）

１）等値条件  where(カラム名: "条件")
#https://pikawaka.com/rails/where
User.where(name: "ぴっか")
# 発行されるSQL
User Load (0.6ms)  SELECT `users`.* FROM `users` WHERE `users`.`name` = 'ぴっか'

２）範囲条件
Client.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
# 発行されるSQL
SELECT * FROM clients WHERE (clients.created_at BETWEEN '2008-12-21 00:00:00' AND '2008-12-22 00:00:00')


３）サブセット条件
Client.where(orders_count: [1,3,5])
# 発行されるSQL
SELECT * FROM clients WHERE (clients.orders_count IN (1,3,5))


■ SQLにおけるwhereとBETWEEN
・概要
WHEREの抽出条件の中に、「A地点からB地点の間」のような条件として検索できる

・例
SELECT * FROM user WHERE id BETWEEN 2 AND 4;

■ SQLにおけるwhereとIN
・概要
複数の一致するかの条件判定をまとめて行うために使用する命令
・例
SELECT * FROM fruit WHERE name IN("みかん","りんご");
#これと同義 SELECT * FROM fruit WHERE name = "みかん" OR name = "りんご";

■ SQLにおけるSELECT
・概要
指定した列のデータを取得する
・例
SELECT [取得したい要素] FROM [使用テーブル];

■ orderメソッド
・概要
データベースから取り出すレコードを特定の順序で並べ替える
・例
Client.order(created_at: :desc)
# または
Client.order(created_at: :asc)
# または
Client.order("created_at DESC")
# または
Client.order("created_at ASC")


■  カラム、レコード、フィールド
https://academy.gmocloud.com/know/20160425/2259
https://26gram.com/database-terms
カラム         列
レコード      行
フィールド セル

■ slectメソッド
指定したものに該当する列（カラム）を取り出す

■ 一括読み込み (eager loading)
Model.findによって返されるオブジェクトに関連付けられたレコードを読み込むためのメカニズムであり、できるだけクエリの使用回数を減らすようにします

■ limitメソッド
取り出すレコード数の上限を指定
Client.limit(5)とすれば、クライアントが最大で5つ返される

■ countメソッド
各モデル(テーブル)のレコード数を獲得するメソッドです。

■ SQLのCOUNT
COUNT(*)はNULL値かどうかに関係なく、取得された行の数を返す
COUNT(カラム名)はNULL値でない値の行数を返す
