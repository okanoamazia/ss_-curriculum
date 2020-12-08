#selfのより細かい理解
https://docs.ruby-lang.org/ja/latest/class/main.html
https://www.atmarkit.co.jp/ait/articles/1501/06/news028_2.html
■ self 
・Rubyリファレンスマニュアル
現在のコンテキストにおいて、暗黙のレシーバーとなるオブジェクト。また、そのオブジェクトを指す擬似変数の名前。
（https://docs.ruby-lang.org/ja/2.7.0/doc/glossary.html#S）
・プログラミングRuby1.9（本）
現在のオブジェクトを読み取る機能をもった変数
（P344）
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
＊本に書いてあるそもそもの大原則
・Rubyでは、「現在のオブジェクト」という概念がある
・Rubyでは、全てのメソッドの呼び出しは特定のオブジェクトに対して行われる
・Rubyでは、メソッドの呼び出しの対象となる特定のオブジェクトは
                    明示的なオブジェクトがある場合は、そのオブジェクトとなり
                    明示的なオブジェクトがない場合は、self（現在のオブジェクト）となる
ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
↓

では、具体的に「現在の」とは何を指すのか実際に見てみる
p self             #=> main                                                  何も定義されていない空間（トップレベル）でのselfという変数のオブジェクトがmainである証拠
p self.class     #=> object                                                mainがobjectクラスのインスタンスである証拠

class Manga
  p self           #=> Manga                                               ClassクラスのオブジェクトであるMangaクラス
  p self.class   #=> Class                                                 MangaクラスのクラスだからClass
 
  def read
    p self          #=> #<Manga:0x00007f84fb0d5ef8>       Mangaクラスのインスタンス
    p self.class  #=> Manga                                              MangaクラスのインスタンスのクラスだからManga
    puts "read"  #=> read                                                 Mangaクラスのインスタンスに対してputsメソッドを実行した結果としての "read""
  end
end
Manga.new.read

↓

つまり、self（現在のオブジェクトという概念）は
①全ての定義されているクラスの外  →   objectクラスのインスタンスであるmainを指す  ＊objectクラスのインスタンスであるから puts メソッドとかが使える
②任意の定義されているクラスの中  →   定義されているクラスを指す（Mangaクラス内であれば、ClassのオブジェクトであるMangaクラスを指す） ＊全てのクラスはClassクラスのオブジェクトであるという概念を前提とした話
③クラスの中のメソッドの中           →   定義されているクラスのインスタンスを指す（Mangaクラス内であれば、Mangaクラスのインスタンスを指す）

＊ちなみに下記の時、selfはDogを指しており、self.classはClassとなる（②のパターン）。
   つまり、下記の時は、明示的にjumpメソッドのレシーバー（呼び出し元のオブジェクト）がDogクラスとされている。
=>だからクラスメソッドという形で使える（クラスに対してクラス内で定義したメソッドを呼び出しできる）
  #試しに、ここでselfを消すと undefined method `jump' for Dog:Class (NoMethodError)  となり、Dogクラス（Classクラスのオブジェクト）に対して呼び出したメソッドが実行できるものがないことになる
class Dog
  def self.jump
    puts "====================="
    p self
    p self.class
    puts "====================="
  end
end
Dog.jump
