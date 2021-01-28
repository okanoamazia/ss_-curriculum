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

■　バリデーションが自動でトリガされるメソッド
create
create!
save
save!
update
update!

■　バリデーションを手動でトリガする方法
・valid？メソッド
・バリデーションを手動でトリガでき、オブジェクトにエラーがない場合はtrueが返され、そうでなければfalseが返されます。

■　バリデーションでエラーが発生した場合
・オブジェクトが保存されない
・エラーメッセージに「.errors.messages」メソッドでアクセスできるようになる（このメソッドはエラーのコレクションを返す）
例）
class Article < ActiveRecord::Base
  validates :title, uniqueness: true
  validates :text, presence: true
end
a1 = Article.create(title:"rain", text:"snow")
a2 = Article.create(title:"rain")
a2.errors
=> #<ActiveModel::Errors:0x00007f876823ba30 @base=#<Article id: nil, title: "rain", text: nil, created_at: nil, updated_at: nil>, @messages={:title=>["has already been taken"], :text=>["can't be blank"]}>
a2.errors.messages
=> {:title=>["has already been taken"], :text=>["can't be blank"]}
a2.errors[:text]
=> ["can't be blank"]
a2.errors.messages[:text]
=> ["can't be blank"]

■   バリデーションの書き方（＊ヘルパーはバリデーションヘルパー、すなわち presence: trueやuniqueness: true のこと）
・1つのカラム
validates :カラム名, ヘルパー

・複数のカラム
validates :カラム名, :カラム名, :カラム名, ヘルパー

・バリデーションヘルパーにオプションを付ける場合
https://udemy.benesse.co.jp/development/system/validates.html
validates :カラム名, ヘルパー: { オプション: オプションの値 }
例）validates :name, length: { maximum: 20 }

■　バリデーションヘルパー
任意の数の属性を受け付けることができるので、1行のコードを書くだけで多くの属性に対して同じバリデーションを実行できます
失敗するたびに、オブジェクトのerrorsコレクションにエラーメッセージが追加される
どのヘルパーでも、:onオプションと:messageオプションは使用可能
:onオプションはバリデーションを実行するタイミングを指定
  例）validates :email, uniqueness: true, on: :create
  (=> createなら作成時、これをupdateにすれば更新時のみバリデーションがかかる)
:messageオプションバリデーション失敗時にerrorsコレクションに追加するメッセージを指定


■　共通のバリデーションオプション
・:allow_blank
本来、{:is: 5} のため5字ないと本来バリデーションに引っかかるが、nilだとしてもこのオプションによってバリデーションをパスできるようになる
class Topic < ApplicationRecord
  validates :title, length: { is: 5 }, allow_blank: true
end
Topic.create(title: nil).valid? # => true

・:on
デフォルトでは保存時（レコードの作成時および更新時の両方）に実行されるバリデーションをどちらかのみにできる
class Person < ApplicationRecord
  validates :name, uniqueness: true, on: :update
end
p1 = Person.new(name: "hoge")
p2 = Person.new(name: "hoge")
#=>これでもバリデーションにひっかからない

＊カスタムコンテキスト
・:on オプションにコンテキスト名を渡すことで作成可能
・何もしないとバリデーションとしては機能しない（トリガーされない）
・バリデーションとして機能させる（トリガー）には、トリガーさせたいメソッドの引数にコンテキスト名を渡す
・明示的なトリガーによるモデルのバリデーションでは、そのコンテキストのみのバリデーションに加えて、コンテキストなしのバリデーションも実行される
class Person < ApplicationRecord
  validates :age, numericality: true, on: :account_setup
  validates :name, presence: true
end

person = Person.new(age: 'thirty-three')
person.valid?(:account_setup) # => false
person.errors.messages
 # => {:age=>["is not a number"], :name=>["can't be blank"]}

■　:messge（エラーメッセージのカスタマイズ）　＊共通の バリデーションオプションの1つでもある
・バリデーション失敗時にerrorsコレクションに追加されるカスタムエラーメッセージを指定できる
・このオプションを使わない場合、Active Recordはバリデーションヘルパーごとにデフォルトのエラーメッセージとなる
・:messageオプションはStringかProcを受け取る

class Person < ApplicationRecord
  # メッセージを直書きした場合
  validates :name, presence: { message: "must be given please" }
  # 動的な属性値を含むメッセージの場合。%{value}は実際の属性値に置き換えられる。%{attribute}や%{model}も利用可能。
  validates :age, numericality: { message: "%{value} seems wrong" }
end

■　errors.add（エラーメッセージの追加）
a2.errors.add(:text, "nodata")
=> ["can't be blank", "nodata"]
or
a2.errors[:text] << "nodata"
=> ["can't be blank", "nodata"]

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


■　カスタムバリデーションの作成方法①カスタムメソッド
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


■　カスタムバリデーションの作成方法②カスタムバリデータ
１，app ディレクトリ内に validators というディレクトリを作成します
２，そのファイルにhoge_validator.rbを作成
３，ファイル内に下記を定義
例）
class HogeValidator < ActiveModel::Validator
  def validate(record)
    unless record.title.starts_with? 'X'
      record.errors[:カラム名] << '名前はXで始まる必要があります'
    end
  end
end
４，使いたいモデルで呼び出し
class Article < ActiveRecord::Base
  validates_with HogeValidator
end

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
