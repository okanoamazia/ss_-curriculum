#Active Record
#バリデーション
#https://railsguides.jp/active_record_validations.html

■　そもそもActiveRecordとは
https://www.atmarkit.co.jp/ait/articles/1104/12/news135.html
・Ruby on Railsを構成する最も重要なライブラリの1つ
・MVCのモデル層に相当
・O/Rマッピングを担当

■　O/Rマッピング（ORM）
・オブジェクト/リレーショナルマッピングの略
・オブジェクトをリレーショナルデータベース(RDBMS)のテーブルに接続すること
　これによって、SQL文を直接書く代りにわずかなアクセスコードを書くだけで、
   アプリケーションのオブジェクトの属性やリレーションシップをデータベースに保存・取得できる

■　Active Recordの主要な機能
・モデルおよびモデル内のデータを表現する
・モデル同士の関連付け(アソシエーション)を表現する
・関連付けられているモデル間の継承階層を表現する
・データをデータベースで永続化する前にバリデーション(検証)を行なう
・データベースをオブジェクト指向スタイルで操作する

■　バリデーション
正しいデータだけをデータベースに保存するために行う
原則モデルに設定する
Railsは、Active Recordオブジェクトを保存する直前にバリデーションを実行し、バリデーションで何らかのエラーが発生すると、オブジェクトを保存しません。

■   バリデーションの書き方（＊ヘルパーはバリデーションヘルパー、すなわち presence: trueやuniqueness: true のこと）
・1つのカラム
validates :カラム名, ヘルパー

・複数のカラム
validates :カラム名, :カラム名, :カラム名, ヘルパー

■　バリデーションヘルパー
任意の数の属性を受け付けることができるので、1行のコードを書くだけで多くの属性に対して同じバリデーションを実行できます
失敗するたびに、オブジェクトのerrorsコレクションにエラーメッセージが追加される
どのヘルパーでも、:onオプションと:messageオプションは使用可能
:onオプションはバリデーションを実行するタイミングを指定
  例）validates :email, uniqueness: true, on: :create
  (=> createなら作成時、これをupdateにすれば更新時のみバリデーションがかかる)
:messageオプションバリデーション失敗時にerrorsコレクションに追加するメッセージを指定

■　条件付きバリデーション
・概要
:ifオプションや:unlessオプションを使うことで特定の条件を満たす場合にのみバリデーションを実行可能（引数にはシンボル、ProcまたはArrayを使用）

・例（シンボル）
バリデーションの実行直前に呼び出されるメソッド名をシンボルで:ifや:unlessオプションに指定する
class Order < ApplicationRecord
  validates :card_number, presence: true, if: :paid_with_card?

  def paid_with_card?
    payment_type == "card"
  end
end
→つまり「payment_type == "card"」の時のみ、「:card_number」に対して「 presence: true」を適用

・例（Procオブジェクト）
LambdaはProcの一種なので、Lambdaも可能
validates :password, confirmation: true, unless: -> { password.blank? }

＊解説
-> { password.blank? }　は　Proc.new{ password.blank? }　と一緒。つまりProcクラスのオブジェクト。
Procクラスのオブジェクトを引数とすることで、別途メソッドを定義せずともバリデーションに条件をつけることが可能
（可能なのは、ActiveRecordの機能の1つだから）
https://railsguides.jp/active_record_validations.html#if%E3%82%84-unless%E3%81%A7%E3%82%B7%E3%83%B3%E3%83%9C%E3%83%AB%E3%82%92%E4%BD%BF%E3%81%86


■　カスタムバリデーションの作成方法（カスタムメソッド）
・概要
validate :メソッド名

def メソッド名
  検証したいコード
end

・例
validate :check_name

def check_name
  if name == "管理人" 　　　→　この部分がバリデーションを設定するカラムとその条件になる（validates :name , presence: true的な部分）
    errors.add(:name, "その名前は使用できません")
  end
end


・URL
https://railsguides.jp/active_record_validations.html#%E3%82%AB%E3%82%B9%E3%82%BF%E3%83%A0%E3%83%90%E3%83%AA%E3%83%87%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E5%AE%9F%E8%A1%8C%E3%81%99%E3%82%8B
https://pikawaka.com/rails/validation
https://qiita.com/h1kita/items/772b81a1cc066e67930e



■　Active Recordのオブジェクト
2つの種類があります。オブジェクトがデータベースの行(row)に対応しているものと、そうでないものです。
たとえば、newメソッドで新しくオブジェクトを作成しただけでは、オブジェクトはデータベースに属していません。
saveメソッドを呼ぶことで、オブジェクトは適切なデータベースのテーブルに保存されます。

■　オブジェクトと属性
>> p = Person.new
# => #<Person id: nil, name: nil>
この時のp、つまりPersonクラスから作られたインスタンスはオブジェクト
このオブジェクトのidやnameが属性

■ オブジェクト
便利な命令（メソッド）を色々持っているデータ型
複数の種類があり、その種類をクラスと呼ぶ
つまりクラスが種類であり、その種類に分類される1つ1つのデータがオブジェクト（インスタンス）

■   インスタンスとクラス
インスタンス：Webサービスを構成するもの（オブジェクトと同義）
クラス         ：インスタンスを作り出すための設計図
クラスの中身：インスタンス変数と特異メソッド・インスタンスメソッド
つまり、基本的にRubyには複数のクラスに分類されるオブジェクトがあり、各オブジェクトが使えるメソッドがある。
そして、サービスを作る上で足りない部分に関しては、自身で新しいクラス（オブジェクトの種類）を定義することで、
特有の変数やメソッドをもったオブジェクトを生成できるようになる。

＊属性
下記のアクセサメソッド（実態はインスタンスメソッドとインスタンス変数）を用いることで、
オブジェクト内のインスタンス変数を外部から変更できるようになるが、
この時オブジェクト内のインスタンス変数（オブジェクトがもつデータ）を属性と呼ぶ
つまり属性の実態はアクセサメソッドが定義されことで外部から取得設定可能になったインスタンス変数

Rubyの文脈　アクセサメソッドが定義されことで外部から取得設定可能になったインスタンス変数
Railsの文脈　Rubyの文脈＋カラムの値（例：userインスタンスのnameの文字数 ）

■　属性とレコード
Userというモデルにnameとoccupationという属性があるとすると、
createメソッドで新しいレコードが1つ作成され、データベースに保存されます

レコード：モデルのオブジェクト（インスタンス）　　　 データベースで言うところの行
属性　　：オブジェクト（インスタンス）がもつデータ    データベースで言うところの列


https://ja.stackoverflow.com/questions/37407/ruby-on-rails%E3%81%A7%E4%BD%BF%E3%82%8F%E3%82%8C%E3%82%8B%E3%83%AC%E3%82%B3%E3%83%BC%E3%83%89%E3%81%A8%E3%81%84%E3%81%86%E7%94%A8%E8%AA%9E%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6

■　new_record？メソッド
DBにレコードが登録されて「いなければ」true　登録されていればfalseになります。
$ bin/rails console
>> p = Person.new(name: "John Doe")
=> #<Person id: nil, name: "John Doe", created_at: nil, updated_at: nil>
>> p.new_record?
=> true
>> p.save
=> true
>> p.new_record?
=> false

■　valid？メソッド
バリデーションを手動でトリガでき、オブジェクトにエラーがない場合はtrueが返され、そうでなければfalseが返されます。

■　errors.messagesインスタンスメソッド
Active Recordでバリデーションが行われた後、発生したエラーにアクセスできます。
このメソッドはエラーのコレクションを返します。

■　errors[:attribute]
特定のオブジェクトの属性が有効かどうかを確認できる

■　exclusion
バリデーションヘルパーの1つ
validates :カラム名, exclusion: { in: ["検証したい文字1", "検証したい文字2"] }
validates :カラム名, exclusion: { in: %w(検証したい文字1 検証したい文字2) }
inで指定した値が、属性の値に含まれていないかを検証
例）
validates :name, exclusion: { in: %w(管理人) }
=>「管理人」と入力された場合は保存されない
