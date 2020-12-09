#ドットインストール

■ irb(Interactive Ruby)
ファイルを作成せずコードを簡単に試せる

■ ri
ライブラリに関するドキュメントを確認できるコマンド

■ 複数行をコメントアウト
=begin    
=end

■ print, puts, p
print 
puts #改行
p      #デバッグ

■ オブジェクト
便利な命令（メソッド）を色々持っているデータ型
複数の種類があり、その種類をクラスと呼ぶ
つまりクラスが種類であり、その種類に分類される1つ1つのデータがオブジェクト（インスタンス）
https://qiita.com/fukumone/items/76e4f04a5188f4abb061
https://tomoyuki65.com/introduction-to-ruby-3/

■ オブジェクト.size
lengthと同じ結果を返す（配列に入っている要素の数を返す）
arry = ["apple", "orange", "mikan"]
arry.size  # => 3 

■  配列オブジェクト.to_h
ハッシュ化する

■   文字列の書き換え
"hello" と%Q(hello) or %(hello) は一緒

■   配列の書き換え
["red", "blue"] と %W(red blue)は一緒

■   while文
i = 0
while i < 5
  puts "#{ i }: hello" 
  i += 1
end

■   メソッドの作成
#メソッドにわたすオプション（ここのname）を引数
def sayHi(name)   
  puts "hi! #{name}"
end
sayHi("taguchi")  #=> "hi! taguchi"
sayHI "taguchi"  #=> "hi! taguchi"

#引数にデフォルト値を設定
def sayHi(name="tom")   
  puts "hi! #{name}"
end
sayHi #=> "hi! tom"

#メソッドの返す値(定義したメソッドの中で最後に評価されたものが戻り値になる)
def sayHi(name="tom")   
   "hi! #{name}"
end
p sayHi #=> "hi! tom"    #sayHiメソッドの返り値が"hi! tom"であり、それをpで出力している

#メソッドの返す値を明示する際はreturnをつける
def sayHi(name="tom")   
  return "hi! #{name}"
end
p sayHi #=> "hi! tom"

■   クラスの作成
class User
  def sayHi
    puts "hi!"
  end
end
tom = User.new
tom.sayHi

class User
  def initialize(name)
    @name = name
  end

  def sayHi
    puts "hi! i am #{@name} "
  end
end
tom = User.new("tom")
tom.sayHi #=> hi! i am tom


■   インスタンスメソッド
クラス構文内で定義されたメソッドのこと。定義されたクラスのインスタンスに対して呼び出せる

■   インスタンス変数
同じインスタンス（オブジェクト）の内部で共有される変数

■   インスタンスとクラス
インスタンス：Webサービスを構成するもの（オブジェクトと同義）
クラス         ：インスタンスを作り出すための設計図
クラスの中身：インスタンス変数とインスタンスメソッド
つまり、基本的にRubyには複数のクラスに分類されるオブジェクトがあり、各オブジェクトが使えるメソッドがある。
そして、サービスを作る上で足りない部分に関しては、自身で新しいクラス（オブジェクトの種類）を定義することで、
特有の変数やメソッドをもったオブジェクトを生成できるようになる。

■   アクセサメソッド  
class User
  attr_accessor :name
=begin    
この記述1つで下記の2つのメソッド（アクセサメソッド）を定義したことになる
tom.name = "John"  のようなことが可能になる .name = (hogehoge)  というsetterメソッド（インスタンス変数を変更する）
  def name= (hogehoge)
    @name= hogehoge
  end
tom.name  => tom   のようなことが可能になる .name                       というgetterメソッド（インスタンス変数を取得する）
  def name
    @name
  end
=end
  
  def initialize(name)
    @name = name
  end

  def sayHi
    puts "hi! i am #{@name} "
  end
end
tom = User.new("tom")
tom.sayHi #=> hi! i am tom

■   selfを使った書き換え(@nameをself.nameに)
#selfは定義したクラス内でそのクラスのインスタンスを表す（例：Userクラス内のself は User.newでつくったインスタンスを指す）
class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def sayHi
    #self.name => tom.name => tomというインスタンスに対して、.nameというgetterメソッドを使っているのと同義 
    #=> つまりtomインスタンスのインスタンス変数(@name)を取得 => 故に、self.name でも @nameでもこの場合同様となる
    puts "hi! i am #{self.name} "
  end
end
tom = User.new("tom")
tom.sayHi #=> hi! i am tom

■   クラスメソッドの作成
class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.info
    puts "User Class"
  end
end

■　継承の書き方
下記で親クラス(Super Class)のメソッドや変数を子クラス(Sub Class)が継承する
class 子クラス < 親クラス

end

■　モジュール
・概要
処理をまとめたもの（＊クラスは処理とデータを1つにまとめたもの）
・書き方
module ModuleName  #1文字目は大文字
  def  メソッド名
  end
end
・使い方（名前空間）
module Men 
  def  student
  end
end

def  student
end

とすることで、ModuleName::メソッド名(Men::student)のように名前空間をつくれる
（同じstudentメソッドでもMenの場合とそれ以外の場合で動作を分けることが可能）
