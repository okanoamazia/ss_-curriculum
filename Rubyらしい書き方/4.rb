#第4章：文の置かれる領域での処理の違い

例題28：動的なメソッド定義
#RE

例題29：同じ内容の要素を繰り返す配列
array = Array.new(3){"foo"}
=> ["foo", "foo", "foo"]

例題30：置換文字列中でのマッチの引用
●回答
"a b c".gsub(/\w/){"(#$&)"}
=> "(a) (b) (c)"｀

●メモ
・gsubの引数にブロック
String.gsub(pattern, replace)
String.gsub(pattern){replace} 　replaceの部分が文字列なら{"hogehoge"}となる 
・正規表現
\w	単語構成文字:[a-zA-Z_0-9]
・「$&」
正規表現によるマッチが行われるたびにマッチした部分文字列が都度上書きされる
https://www.javadrive.jp/ruby/regex/backreference/index1.html
・式展開の{}の省略
$&の前のシャープは式展開における{}の省略した形(ローカル変数以外の変数であれば可能な様子)
@user=ken
puts "hello #{@user}"　=> hello ken
puts "hello #@user"　  => hello ken
http://vector.hateblo.jp/entry/20111025/1319545096

